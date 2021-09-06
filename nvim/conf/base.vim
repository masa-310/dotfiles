filetype plugin indent on
syntax on
syntax enable

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
set fileformats=unix,dos,mac

" load configurations for indentation and plugin
filetype plugin indent on

" colorscheme
colorscheme molokai

"viminfo, swap and other files for persistent
set viminfo+=n/var/tmp/vim/viminfo
set directory=/var/tmp/vim/
set undodir=/var/tmp/vim/
set backupdir=/var/tmp/vim/
set writebackup

" scroll
set scrolloff=4

" clipboard
set clipboard=unnamedplus

" decoration
set number
set list
set listchars=eol:¶,trail:~,tab:\|\ 

" indentation
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2 "indent for continuous spaces
set autoindent
set smartindent

" searching
set smartcase "distinguish upper/lower case
set incsearch "search per a charactor
set hlsearch " hilight

" buffer
set hidden "enable us to change buffer without saving


" rustのcindentを消す
autocmd FileType rust setlocal nocindent
