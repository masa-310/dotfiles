" 3<leader>tl will clear neoterm-3.
nnoremap <leader>tl :<c-u>exec v:count.'Tclear'<cr>
let g:neoterm_default_mod='vertical belowright'
let g:neoterm_size=80
let g:neoterm_autoscroll=1

nnoremap <c-p> :Ttoggle<CR>
tnoremap <c-p> <C-¥><C-n>:Ttoggle<CR>
