" buffer
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" tab
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [T :tabfirst<CR>
nnoremap <silent> ]T :tabnext<CR>

" https://qiita.com/wadako111/items/755e753677dd72d8036d
nnoremap  [Tag] <Nop>
nmap      t [Tag]
  " Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
nnoremap <silent> tc :tabclose<CR>

  " split
nnoremap <silent> [j <C-w>j
nnoremap <silent> [k <C-w>k
nnoremap <silent> [l <C-w>l
nnoremap <silent> [h <C-w>h
nnoremap <silent> [H <C-w>H
nnoremap <silent> [w <C-w>w
