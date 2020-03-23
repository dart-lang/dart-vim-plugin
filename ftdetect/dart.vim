augroup dart-vim-plugin-ftdetec
  autocmd!
  autocmd BufRead,BufNewFile *.dart set filetype=dart
  autocmd BufRead * call s:DetectShebang()
augroup END

function! s:DetectShebang()
  if did_filetype() | return | endif
  if getline(1) ==# '#!/usr/bin/env dart'
    setlocal filetype=dart
  endif
endfunction
