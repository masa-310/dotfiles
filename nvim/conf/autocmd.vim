" rustのcindentを消す
autocmd FileType rust setlocal nocindent

" scala call build-import
autocmd FileType scala call CocAction("runCommand", "build-import")
