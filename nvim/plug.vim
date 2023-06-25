call plug#begin()
" Add or remove your plugins here like this:
" Plug 'Shougo/denite.nvim'
" Plug 'Shougo/neomru.vim'
Plug 'thinca/vim-quickrun'
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
"  Plug 'jistr/vim-nerdtree-tabs'
Plug 'alvan/vim-closetag'
"  Plug 'Shougo/neosnippet'
"  Plug 'Shougo/neosnippet-snippets'
"  Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
"  Plug 'Shougo/deoplete.nvim'
Plug 'tpope/vim-surround'
Plug 'cohama/lexima.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/vimproc'
"elixir
" Plug 'elixir-editors/vim-elixir'
" js/typescript
"  syntax
" Plug 'othree/yajs'
" Plug 'digitaltoad/vim-pug'
"  jsx syntax
" Plug 'MaxMEllon/vim-jsx-pretty'
"  typescript syntax
" Plug 'leafgarland/typescript-vim'
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
" Plug 'andys8/vim-elm-syntax'
Plug 'elm-tooling/elm-language-server'
Plug 'jparise/vim-graphql'

" purescript syntax highlight
" Plug 'raichoo/purescript-vim'

Plug 'tpope/vim-fugitive'

" Plug 'lervag/vimtex'

" Plug 'nikvdp/ejs-syntax'

" Plug 'sirtaj/vim-openscad'

" Plug 'kassio/neoterm'
Plug 'tyru/open-browser.vim'
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Plug 'aklt/plantuml-syntax'
" Plug 'posva/vim-vue'
" Plug 'udalov/kotlin-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'whonore/Coqtail'
Plug 'scalameta/nvim-metals'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'github/copilot.vim'
Plug 'sheerun/vim-polyglot'

call plug#end()

