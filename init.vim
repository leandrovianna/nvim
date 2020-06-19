"" nvim config

"" === Plug config ===

call plug#begin()

"" General Plugins 
Plug 'neomake/neomake'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'itchyny/lightline.vim'

"" quote and bracket completion
Plug 'jiangmiao/auto-pairs'

"" formatter
Plug 'sbdchd/neoformat'

"" comment plugin - <Leader>cc <Leader>cu
Plug 'scrooloose/nerdcommenter'

"" make gvim-only colorschemes work in terminal
Plug 'vim-scripts/CSApprox'
""""

"" autocomplete - needs python3 support
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
""""

""" Python
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
" fold helper for python
Plug 'tmhedberg/SimpylFold'

"" Git
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-git'
""""

"" Golang
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'godoctor/godoctor.vim', { 'for': 'go' }

" autocomplete, depends on gocode
Plug 'zchee/deoplete-go', {'build': {'unix': 'make'}, 'for': 'go'}
""""

"" Dart lang
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }

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

"" open files in the last place
Plug 'farmergreg/vim-lastplace'

"" scala
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }

""" cpp
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }

"" switch from header file to cpp file (vice versa)
Plug 'ericcurtin/CurtineIncSw.vim', { 'for': ['cpp', 'c'] }

""" julia
Plug 'JuliaEditorSupport/julia-vim', { 'for': 'julia' }

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

"" Copy and Paste facilities
map <Leader>y "+y
map <Leader>p "+p

"" select a interval and :FormatJSON
com! FormatJSON %!python3 -m json.tool

augroup myautocmd
  autocmd!

  """ Indentation file-specific options
  " au Filetype cpp,c,java setlocal ts=4 sw=4 expandtab
  " au Filetype typescript,javascript,html,css setlocal ts=2 sw=2 expandtab

  "" Swap CapsLock and Esc key
  "" au VimEnter * :silent !setxkbmap -option caps:swapescape
  "" au VimLeave * :silent !setxkbmap -option
  au InsertLeave,WinEnter * let &l:foldmethod=g:oldfoldmethod
  au InsertEnter,WinLeave * let g:oldfoldmethod=&l:foldmethod | setlocal foldmethod=manual

  " au FileType xml exe ":silent %!xmllint --format --recover - 2>/dev/null"
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

"" Go Fmt keep folding
let g:go_fmt_experimental = 1

"" CurtineIncSw config (switch between header and cpp file)
map <Leader>s :call CurtineIncSw()<CR>

"" Neomake with Standard JS local
let g:neomake_javascript_enabled_makers = ['standard', 'eslint']
let g:neomake_javascript_standard_maker = {
        \ 'exe': $PWD . '/node_modules/.bin/standard'
        \ }

"" Deoplete settings
let g:deoplete#enable_at_startup = 1

"" deoplete-jedi - close preview top window
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

""" neoformat settings """
" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1
 
" enable matchit plugin for julia blocks
runtime macros/matchit.vim
