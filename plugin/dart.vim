" Reformats the current buffer with dartformat
" To install dartformat: pub global activate dart_style
function! DartFormat()
  execute "%!dartfmt " . bufname("%")
endfunction
command! DartFormat call DartFormat()
