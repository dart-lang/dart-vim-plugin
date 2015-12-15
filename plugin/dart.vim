
if exists('g:loaded_dart')
  finish
endif
let g:loaded_dart = 1

let s:save_cpo = &cpo
set cpo&vim

augroup dart-vim-plugin
  autocmd!
  autocmd FileType dart command! -buffer -nargs=? DartFmt       call dart#fmt(<q-args>)
  autocmd FileType dart command! -buffer -nargs=? Dart2Js       call dart#tojs(<q-args>)
  autocmd FileType dart command! -buffer -nargs=? DartAnalyzer  call dart#analyzer(<q-args>)
augroup END

let &cpo = s:save_cpo
