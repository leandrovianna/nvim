"" nvim config

"" === Plug config ===

call plug#begin()

"" General Plugins 
Plug 'neomake/neomake'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

"" needs python3 support
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
""""

"" Git
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-git'
""""

"" Golang
Plug 'fatih/vim-go', { 'for': 'go' }

"" depends on gocode
Plug 'zchee/deoplete-go', { 'do': 'make' }
""""

"" Dart lang
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
""""

"" Markdown
Plug 'plasticboy/vim-markdown', { 'for' : 'markdown' }

Plug 'godlygeek/tabular', { 'for': 'markdown' }

Plug 'JamshedVesuna/vim-markdown-preview', { 'for': 'markdown' }
""""

"" Typescript
Plug 'mhartington/nvim-typescript/', { 'for': 'typescript' }
""""

"" Html, Jinja and templates
Plug 'lepture/vim-jinja', { 'for' : 'html.jinja' }

Plug 'mattn/emmet-vim', { 'for': 'html' }
""""

"" Json
Plug 'elzr/vim-json', { 'for': 'json' }
""""

"" Colorschemes
Plug 'jeffkreeftmeijer/vim-dim'

Plug 'vim-scripts/dante.vim'

Plug 'ajmwagar/vim-deus'
""""

call plug#end()

"" === General Config ===

syntax on
set autoread
set ruler
set number
set incsearch
set autoindent
set copyindent
set nowrap

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set mouse=c

set background="dark"
set termguicolors

"" Colorscheme
colorscheme deus

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

"" New leader key (,)
let mapleader=','

"" List of Buffers
nmap <Leader>b :buffers<CR>

"" :FormatJSON
com! FormatJSON !python -m json.tool

augroup myautocmd
  autocmd!

  """ Indentation file-specific options
  au Filetype cpp,c setlocal ts=4 sw=4 expandtab
  au Filetype typescript,javascript,html,css setlocal ts=2 sw=2 expandtab

  "" Swap CapsLock and Esc key
  au VimEnter * :silent !setxkbmap -option caps:swapescape
  au VimLeave * :silent !setxkbmap -option
augroup end

"" === Plugins Config ===

call neomake#configure#automake('rw', 500)

