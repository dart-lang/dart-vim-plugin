
if exists('g:loaded_dart')
  finish
endif
let g:loaded_dart = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:FormatOnSave()
  " Dart code formatting on save
  if get(g:, 'dart_format_on_save', 0)
    call dart#fmt('')
  endif
endfunction

augroup dart-vim-plugin
  autocmd!
  autocmd BufWritePre *.dart call s:FormatOnSave()
  autocmd FileType dart command! -buffer -nargs=? DartFmt       call dart#fmt(<q-args>)
  autocmd FileType dart command! -buffer DartToggleFormatOnSave call dart#ToggleFormatOnSave()
  autocmd FileType dart command! -buffer -nargs=? Dart2Js       call dart#tojs(<q-args>)
  autocmd FileType dart command! -buffer -nargs=? DartAnalyzer  call dart#analyzer(<q-args>)
  autocmd Filetype dart call dart#setModifiable()
augroup END

let &cpo = s:save_cpo
