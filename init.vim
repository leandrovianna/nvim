"" nvim config

"" === Plug config ===

call plug#begin()

"" General Plugins 
Plug 'neomake/neomake'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'itchyny/lightline.vim'

"" Languages Servers
" Plug 'natebosch/vim-lsc'

"" make gvim-only colorschemes work in terminal
Plug 'vim-scripts/CSApprox'
""""

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
Plug 'dart-lang/dart-vim-plugin', { 'commit': '90d92be', 'for': 'dart' }

" Plug 'natebosch/vim-lsc-dart', { 'for' : 'dart' }
""""

"" Markdown
Plug 'plasticboy/vim-markdown', { 'for' : 'markdown' }

Plug 'godlygeek/tabular', { 'for': 'markdown' }

" press Ctrl-p
Plug 'JamshedVesuna/vim-markdown-preview', { 'for': 'markdown' }
""""

"" Typescript
Plug 'mhartington/nvim-typescript/', { 'for': 'typescript' }
""""

"" Html, Jinja and templates
Plug 'lepture/vim-jinja', { 'for' : 'html.jinja' }
""""

"" Json
Plug 'elzr/vim-json', { 'for': 'json' }
""""

"" Protobuf
Plug 'uarun/vim-protobuf'
"""

"" Lua
Plug 'xolox/vim-lua-ftplugin'

"" depedencies
Plug 'xolox/vim-misc'
"""

Plug 'farmergreg/vim-lastplace'

"" Colorschemes
Plug 'jeffkreeftmeijer/vim-dim'

Plug 'vim-scripts/dante.vim'

Plug 'ajmwagar/vim-deus'

Plug 'notpratheek/vim-sol'

Plug 'jacoborus/tender.vim'

Plug 'vim-scripts/Fruidle'

Plug 'srcery-colors/srcery-vim'
""""

call plug#end()

"" === General Config ===

syntax on
set autoread
set autowrite
set ruler
set number
set incsearch
set autoindent
set copyindent
set nowrap
set modeline

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set mouse=c

set foldmethod=syntax

"" Colorscheme
set termguicolors

let night = 22
let morning = 6
let hour_now = strftime('%H')
"" use colorscheme dark if hour_now is [night, morning)
execute 'set background=' . (night <= hour_now || hour_now < morning ? 'dark' : 'light')
execute 'colorscheme ' . (night <= hour_now || hour_now < morning ? 'tender' : 'fruidle')
"" colorscheme fruidle

"" Lightline
let g:lightline = {'colorscheme': 'tender'}

"" New leader key (,)
let mapleader=','

"" List of Buffers
nmap <Leader>b :buffers<CR>

"" Copy and Pasta facilities
map <Leader>y "+y
map <Leader>p "+p

"" :FormatJSON
com! FormatJSON !python3 -m json.tool

augroup myautocmd
  autocmd!

  """ Indentation file-specific options
  au Filetype cpp,c,java setlocal ts=4 sw=4 expandtab
  au Filetype typescript,javascript,html,css setlocal ts=2 sw=2 expandtab

  "" Swap CapsLock and Esc key
  "" au VimEnter * :silent !setxkbmap -option caps:swapescape
  "" au VimLeave * :silent !setxkbmap -option
augroup end

"" === Plugins Config ===

call neomake#configure#automake('rw', 300)

"" Vim-markdown-preview
let vim_markdown_preview_use_xdg_open=1
let vim_markdown_preview_github=1

"" Ultisnips config
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-m>"

"" Dart config
let dart_format_on_save = 1
let dart_style_guide = 2
