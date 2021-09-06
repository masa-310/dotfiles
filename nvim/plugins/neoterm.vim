" 3<leader>tl will clear neoterm-3.
nnoremap <leader>tl :<c-u>exec v:count.'Tclear'<cr>
let g:neoterm_default_mod='belowright'
let g:neoterm_size=10

nnoremap <c-p> :Ttoggle<CR>
tnoremap <c-p> <C-¥><C-n>:Ttoggle<CR>
