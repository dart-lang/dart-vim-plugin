
if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

let &l:errorformat =
  \ ' %#''file://' . ((has('win32') || has('win64')) ? '/' : '') . '%f'': %s: line %l pos %c:%m,%m (file://%f:%l:%c),%m'

setlocal expandtab
setlocal commentstring=//\ %s
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal cindent
setlocal cinoptions+=j1,J1

