" Required for operations modifying multiple buffers like rename.
let g:LanguageClient_rootMakers = {
  \ 'haskell': ['*.cabal', 'stack.yaml'],
  \ } 
let g:LanguageClient_serverCommands = {
  \ 'haskell': ['hie-wrapper'],
  \ }

" LanguageClientの機能のショートカットを登録
function LC_maps()
  set hidden
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <silent> <F5> :call LanguageClient_contextMenu()<CR>
    map <silent> <Leader>lh :call LanguageClient#textDocument_hover()<CR>
    map <silent> <Leader>ld :call LanguageClient#textDocument_definition()<CR>
    map <silent> <Leader>lr :call LanguageClient#textDocument_rename()<CR>
    map <silent> <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
    map <silent> <Leader>lb :call LanguageClient#textDocument_references()<CR>
    map <silent> <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
    map <silent> <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
  endif
endfunction

augroup LanguageClientKeyconfig
  autocmd!
  autocmd Filetype haskell call LC_maps()
augroup END
