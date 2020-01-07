" my autocmd
"  typescript
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.tsx set filetype=typescript

" my functions
let nltoggle_on = 0
function! NLToggle()
  if g:nltoggle_on == 0
    set nonumber
    set nolist
    let g:nltoggle_on = 1
  else
    set number
    set list
    let g:nltoggle_on = 0
  endif
endfunction
function! GenerateID(range)
  let cmd = 'cat /dev/urandom | tr -dc "a-zA-Z0-9" | fold -w ' . a:range . ' | head -n 1'
  execute ":normal a" . strpart(system(cmd), 0, a:range)
endfunction

" my commands
command! NLToggle call NLToggle()
command! -nargs=1 GenerateID call GenerateID(<f-args>)

" cquery
" http://kutimoti.hatenablog.com/entry/2018/06/09/165225
function! MakeCquery()
  let temp = expand('%:p')
  let dir = expand('%:p:h')
  echo system('echo ''[{"directory": "' . dir . '" ,"command": "clang  ' . temp . ' -std=c++11","file": "' . temp . '"}]'' > compile_commands.json')
endfunction
