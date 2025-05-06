exec 'set runtimepath+=' . expand("<sfile>:p:h")
exec 'set runtimepath+=' . expand("<sfile>:p:h") . '/plugins'
runtime lazy.lua
runtime! conf/*
runtime! plugins/*.vim
runtime! plugins/*.lua
