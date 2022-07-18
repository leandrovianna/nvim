"" nvim config

"" ============================================================================
"" Plug config

call plug#begin()

"" General Plugins 
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'itchyny/lightline.vim'

"" autocompletion and LSP
Plug 'neovim/nvim-lspconfig'
"Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}

"" LanguageTool support
Plug 'rhysd/vim-grammarous'

"" Unix command for vim
Plug 'tpope/vim-eunuch'
"

"" formatter
Plug 'sbdchd/neoformat'

"" comment plugin - <Leader>cc <Leader>cu
Plug 'scrooloose/nerdcommenter'

"" make gvim-only colorschemes work in terminal
Plug 'vim-scripts/CSApprox'
""""

"" trailing whitespace
Plug 'axelf4/vim-strip-trailing-whitespace'

"" Git
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-git'

Plug 'airblade/vim-gitgutter'
""""

"" Golang
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'godoctor/godoctor.vim', { 'for': 'go' }
""""

"" Dart lang
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
""""

"" Flutter
Plug 'reisub0/hot-reload.vim', { 'for': 'dart' }
"

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
Plug 'lepture/vim-jinja', { 'for': 'html.jinja' }

"" Emmet - write html fast
Plug 'mattn/emmet-vim', { 'for': 'html' }
""""

"" Json
Plug 'elzr/vim-json', { 'for': 'json' }
""""

"" Protobuf
Plug 'uarun/vim-protobuf', { 'for': 'proto' }
"""

"" Lua
Plug 'xolox/vim-lua-ftplugin', { 'for': 'lua' }

"" depedencies
Plug 'xolox/vim-misc'
"""

"" open files in the last place
Plug 'farmergreg/vim-lastplace'

"" scala
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }

""" cpp
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }

"" switch from header file to cpp file (vice versa)
Plug 'ericcurtin/CurtineIncSw.vim', { 'for': ['cpp', 'c'] }

""" Qt support
Plug 'fedorenchik/qt-support.vim', { 'for': 'cpp' }

""" julia
Plug 'JuliaEditorSupport/julia-vim', { 'for': 'julia' }

"" Colorschemes
Plug 'ajmwagar/vim-deus'
""""

call plug#end()
"" ============================================================================

"" ============================================================================
"" General Config

syntax on                       " syntax highlighting, see :help syntax
filetype plugin indent on       " file type detection, see :help filetype
set number                      " display line number
set relativenumber              " display relative line numbers
set path+=**                    " improves searching, see :help path
set noswapfile                  " disable use of swap files
set wildmenu                    " completion menu
set backspace=indent,eol,start  " ensure proper backspace functionality
set undodir=~/.cache/nvim/undo  " undo ability will persist after exiting file
set undofile                    " see :help undodir and :help undofile
set incsearch                   " see results while search is being typed, see :help incsearch
set smartindent                 " auto indent on new lines, see :help smartindent
set ic                          " ignore case when searching
set colorcolumn=80              " display color when line reaches pep8 standards
set expandtab                   " expanding tab to spaces
set tabstop=4                   " setting tab to 4 columns
set shiftwidth=4                " setting tab to 4 columns
set softtabstop=4               " setting tab to 4 columns
set showmatch                   " display matching bracket or parenthesis
set hlsearch incsearch          " highlight all pervious search pattern with incsearch

"" ============================================================================

"" ============================================================================
"" Colorscheme
set termguicolors
colorscheme deus

"" New leader key (,)
let mapleader=','

"" List of Buffers
nmap <Leader>b :buffers<CR>

"" Copy and Paste facilities
map <Leader>y "+y
map <Leader>p "+p

"" select a interval and :FormatJSON
com! FormatJSON %!python3 -m json.tool

" display ugly bright red bar at color column number
highlight ColorColumn ctermbg=9

" Keybind Ctrl+l to clear search
nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>

" When python filetype is detected, F5 can be used to execute script
autocmd FileType python nnoremap <buffer> <F5> :w<cr>:exec '!clear'<cr>:exec '!python3' shellescape(expand('%:p'), 1)<cr>
"" ============================================================================

"" ============================================================================
"" Plugins Config

"" Vim-markdown-preview
let vim_markdown_preview_use_xdg_open=1
let vim_markdown_preview_github=1

"" Ultisnips config
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-m>"

"" Dart config
let dart_format_on_save = 1
let dart_style_guide = 2

"" Go Fmt keep folding
let g:go_fmt_experimental = 1

"" CurtineIncSw config (switch between header and cpp file)
map <Leader>s :call CurtineIncSw()<CR>

" enable matchit plugin for julia blocks
runtime macros/matchit.vim

" enable spell on text files
autocmd FileType markdown,text setlocal spell
"" ============================================================================

"" ============================================================================
"" LSP configuration
"" pylsp - python
lua require'lspconfig'.pylsp.setup{}
