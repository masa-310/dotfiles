exec 'set runtimepath+=' . expand("<sfile>:p:h") . '/plugins'

runtime plug.vim
runtime! conf/*
runtime! plugins/*.vim
runtime! plugins/*.lua
