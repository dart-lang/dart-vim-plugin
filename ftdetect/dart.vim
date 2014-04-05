
augroup dart-vim-plugin
  autocmd!
  autocmd BufRead,BufNewFile *.dart set filetype=dart
augroup END

let &l:errorformat = '''file://%f'': error: line %l pos %c:%m,%m (file://%f:%l:%c),%m'
setlocal expandtab
setlocal commentstring=//\ %s
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal cindent
setlocal cinoptions+=j1,J1

