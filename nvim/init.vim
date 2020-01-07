call plug#begin('~/.local/share/nvim/plugged')
" Add or remove your plugins here like this:
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
Plug 'thinca/vim-quickrun'
Plug 'scrooloose/nerdtree'
"  Plug 'jistr/vim-nerdtree-tabs'
Plug 'alvan/vim-closetag'
"  Plug 'Shougo/neosnippet'
"  Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
"  Plug 'Shougo/deoplete.nvim'
Plug 'tpope/vim-surround'
Plug 'cohama/lexima.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/vimproc'
"elixir
Plug 'elixir-editors/vim-elixir'
" js/typescript
"  syntax
Plug 'othree/yajs'
Plug 'digitaltoad/vim-pug'
"  jsx syntax
Plug 'MaxMEllon/vim-jsx-pretty'
"  typescript syntax
Plug 'leafgarland/typescript-vim'
"Plug 'ianks/vim-tsx'
" terraform
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
" language
"Plug 'autozimu/LanguageClient-neovim', {
"  \ 'rev': 'next',
"  \ 'build': 'bash install.sh',
"  \ }
" Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
 " elm
Plug 'andys8/vim-elm-syntax'
Plug 'elm-tooling/elm-language-server'
Plug 'jparise/vim-graphql'

Plug 'tpope/vim-fugitive'

Plug 'lervag/vimtex'
call plug#end()

syntax enable

set shell=/bin/sh
let s:base_dir = expand('~/.dotfiles/nvim')
execute 'set runtimepath+=' . fnamemodify(s:base_dir, ':p')
runtime! conf/*.vim
runtime! plugins/*.vim
