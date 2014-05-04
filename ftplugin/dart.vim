
if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

let s:win_sep = (has('win32') || has('win64')) ? '/' : ''

let &l:errorformat =
  \ join([
  \   ' %#''file://' . s:win_sep . '%f'': %s: line %l pos %c:%m',
  \   '%m'
  \ ], ',')

setlocal expandtab
setlocal commentstring=//\ %s
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal cindent
setlocal cinoptions+=j1,J1

