" rustのcindentを消す
autocmd FileType rust setlocal nocindent

" scala call build-import
autocmd BufReadPost scala call CocActionAsync("runCommand", "build-import")
