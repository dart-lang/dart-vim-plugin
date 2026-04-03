
function! s:error(text) abort
  echohl Error
  echomsg printf('[dart-vim-plugin] %s', a:text)
  echohl None
endfunction

function! s:cexpr(errorformat, lines, reason) abort
  call setqflist([], ' ', {
      \ 'lines': a:lines,
      \ 'efm': a:errorformat,
      \ 'context': {'reason': a:reason},
      \})
  copen
endfunction

" If the quickfix list has a context matching [reason], clear and close it.
function! s:clearQfList(reason) abort
  let context = get(getqflist({'context': 1}), 'context', {})
  if type(context) == v:t_dict &&
      \ has_key(context, 'reason') &&
      \ context.reason == a:reason
    call setqflist([], 'r')
    cclose
  endif
endfunction

function! dart#fmt(...) abort
  let l:dartfmt = s:FindDartFmt()
  if empty(l:dartfmt) | return | endif
  let buffer_content = getline(1, '$')
  let l:cmd = extend(l:dartfmt, ['--stdin-name', expand('%')])
  if exists('g:dartfmt_options')
    call extend(l:cmd, g:dartfmt_options)
  endif
  call extend(l:cmd, a:000)
  let l:stdout_data = []
  let l:stderr_data = []
  let l:options = {
      \ 'out_cb': { ch, msg -> add(l:stdout_data, msg) },
      \ 'err_cb': { ch, msg -> add(l:stderr_data, msg) },
      \ 'close_cb': { ch ->
      \    s:formatResult(l:stdout_data, l:stderr_data, l:buffer_content)} }
  if has('patch-8.1.350')
    let options['noblock'] = v:true
  endif
  let l:job = job_start(l:cmd, l:options)
  call ch_sendraw(job_getchannel(l:job), join(l:buffer_content, "\n"))
  call ch_close_in(job_getchannel(l:job))
endfunction

function! s:formatResult(stdout, stderr, buffer_content) abort
  if a:buffer_content == a:stdout
    call s:clearQfList('dartfmt')
    return
  endif
  if !empty(a:stdout)
    let win_view = winsaveview()
    silent keepjumps call setline(1, a:stdout)
    if line('$') > len(a:stdout)
      silent keepjumps execute string(len(a:stdout)+1).',$ delete'
    endif
    call winrestview(win_view)
    call s:clearQfList('dartfmt')
  else
    let l:has_diagnostic = v:false
    for l:line in a:stderr
      if l:line =~# '^line \d\+, column \d\+ of '
        let l:has_diagnostic = v:true
        break
      endif
    endfor

    if l:has_diagnostic
      let l:format = '%Aline %l\, column %c of %f: %m,%C%.%#,%-G%.%#'
    else
      let l:format = '%m'
    endif
    call s:cexpr(l:format, a:stderr, 'dartfmt')
  endif
endfunction

function! s:FindDartFmt() abort
  if exists('g:dartfmt_command')
    return type(g:dartfmt_command) == v:t_list
        \ ? g:dartfmt_command
        \ : [g:dartfmt_command]
  endif
  if executable('dart')
    return ['dart', 'format']
  endif
  call s:error('Cannot find a `dart` command')
  return []
endfunction

" Finds the path to `uri`.
"
" If the file is a package: uri, looks for a package_config.json or .packages
" file to resolve the path. If the path cannot be resolved, or is not a
" package: uri, returns the original.
function! dart#resolveUri(uri) abort
  if a:uri !~# 'package:'
    return a:uri
  endif
  let package_name = substitute(a:uri, 'package:\(\w\+\)\/.*', '\1', '')
  let [found, package_map] = s:PackageMap()
  if !found
    call s:error('cannot find .packages or package_config.json file')
    return a:uri
  endif
  if !has_key(package_map, package_name)
    call s:error('no package mapping for '.package_name)
    return a:uri
  endif
  let package_lib = package_map[package_name]
  return substitute(a:uri,
      \ 'package:'.package_name,
      \ escape(package_map[package_name], '\'),
      \ '')
endfunction

" A map from package name to lib directory parse from a 'package_config.json'
" or '.packages' file.
"
" Returns [found, package_map]
function! s:PackageMap() abort
  let [found, package_config] = s:FindFile('.dart_tool/package_config.json')
  if found
    let dart_tool_dir = fnamemodify(package_config, ':p:h')
    let content = join(readfile(package_config), "\n")
    let packages_dict = json_decode(content)
    if packages_dict['configVersion'] != '2'
      s:error('Unsupported version of package_config.json')
      return [v:false, {}]
    endif
    let map = {}
    for package in packages_dict['packages']
      let name = package['name']
      let uri = package['rootUri']
      let package_uri = package['packageUri']
      if uri =~# 'file:/'
        let uri = substitute(uri, 'file://', '', '')
        let lib_dir = resolve(uri.'/'.package_uri)
      else
        let lib_dir = resolve(dart_tool_dir.'/'.uri.'/'.package_uri)
      endif
      let map[name] = lib_dir
    endfor
    return [v:true, map]
  endif

  let [found, dot_packages] = s:FindFile('.packages')
  if found
    let dot_packages_dir = fnamemodify(dot_packages, ':p:h')
    let lines = readfile(dot_packages)
    let map = {}
    for line in lines
      if line =~# '\s*#'
        continue
      endif
      let package = substitute(line, ':.*$', '', '')
      let lib_dir = substitute(line, '^[^:]*:', '', '')
      if lib_dir =~# 'file:/'
        let lib_dir = substitute(lib_dir, 'file://', '', '')
        if lib_dir =~# '/[A-Z]:/'
          let lib_dir = lib_dir[1:]
        endif
      else
        let lib_dir = resolve(dot_packages_dir.'/'.lib_dir)
      endif
      if lib_dir =~# '/$'
        let lib_dir = lib_dir[:len(lib_dir) - 2]
      endif
      let map[package] = lib_dir
    endfor
    return [v:true, map]
  endif
  return [v:false, {}]
endfunction

" Toggle whether dartfmt is run on save or not.
function! dart#ToggleFormatOnSave() abort
  if get(g:, 'dart_format_on_save', 0)
    let g:dart_format_on_save = 0
    return
  endif
  let g:dart_format_on_save = 1
endfunction

" Finds a file named [a:path] in the cwd, or in any directory above the open
" file.
"
" Returns [found, file]
function! s:FindFile(path) abort
  if filereadable(a:path)
    return [v:true, a:path]
  endif
  let dir_path = expand('%:p:h')
  while v:true
    let file_path = dir_path.'/'.a:path
    if filereadable(file_path)
      return [v:true, file_path]
    endif
    let parent = fnamemodify(dir_path, ':h')
    if dir_path == parent
      break
    endif
    let dir_path = parent
  endwhile
  return [v:false, '']
endfunction

" Prevent writes to files in the pub cache.
function! dart#setModifiable() abort
  let full_path = expand('%:p')
  if full_path =~# '.pub-cache' ||
      \ full_path =~# 'Pub\Cache'
    setlocal nomodifiable
  endif
endfunction
