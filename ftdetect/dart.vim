autocmd BufRead,BufNewFile *.dart set filetype=dart

function! s:DetectShebang()
  if did_filetype() | return | endif
  if getline(1) == '#!/usr/bin/env dart'
    setlocal filetype=dart
  endif
endfunction

autocmd BufRead * call s:DetectShebang()
