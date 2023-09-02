--------------------------------------------------------------------------------
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- General Plugins 
Plug ('scrooloose/nerdtree', { on =  'NERDTreeToggle'})

Plug 'itchyny/lightline.vim'

-- autocompletion and LSP
Plug 'neovim/nvim-lspconfig'

Plug ('ms-jpq/coq_nvim', {branch = 'coq', ['do'] = ':COQdeps'})

-- 9000+ Snippets
Plug ('ms-jpq/coq.artifacts', {branch = 'artifacts'})

-- Unix command for vim
Plug 'tpope/vim-eunuch'

-- comment plugin - <Leader>cc <Leader>cu
Plug 'scrooloose/nerdcommenter'

-- make gvim-only colorschemes work in terminal
Plug 'vim-scripts/CSApprox'

-- trailing whitespace
Plug 'axelf4/vim-strip-trailing-whitespace'

-- open files in the last place
Plug 'farmergreg/vim-lastplace'
--------------------------------------------------------------------------------

-- Git
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-git'

Plug 'airblade/vim-gitgutter'
--------------------------------------------------------------------------------

-- Python
Plug ('heavenshell/vim-pydocstring',
    {['for'] = 'python', ['do'] = 'make install'})
--------------------------------------------------------------------------------

-- Golang
Plug ('fatih/vim-go', {['for'] = 'go', ['do'] = ':GoUpdateBinaries'})
Plug ('godoctor/godoctor.vim', {['for'] = 'go'})
--------------------------------------------------------------------------------

-- Dart lang
Plug ('dart-lang/dart-vim-plugin', {['for'] = 'dart'})
--------------------------------------------------------------------------------

-- Flutter
Plug ('reisub0/hot-reload.vim', {['for'] = 'dart'})
--------------------------------------------------------------------------------

-- Markdown
Plug ('plasticboy/vim-markdown', {['for']  = 'markdown'})

Plug ('godlygeek/tabular', {['for'] = 'markdown'})

-- press Ctrl-p
Plug ('JamshedVesuna/vim-markdown-preview', {['for'] = 'markdown'})
--------------------------------------------------------------------------------

-- Typescript
Plug 'leafgarland/typescript-vim'

-- JSX
Plug 'MaxMEllon/vim-jsx-pretty'
--------------------------------------------------------------------------------

-- Html, Jinja and templates
Plug ('lepture/vim-jinja', {['for'] = 'html.jinja'})
--------------------------------------------------------------------------------

-- Emmet - write html fast
Plug ('mattn/emmet-vim', {['for'] = {'html', 'css', 'javascript', 'typescript'}})
--------------------------------------------------------------------------------

-- Json
Plug ('elzr/vim-json', {['for'] = 'json'})
--------------------------------------------------------------------------------

-- Protobuf
Plug ('uarun/vim-protobuf', {['for'] = 'proto'})
--------------------------------------------------------------------------------

-- Lua
Plug ('xolox/vim-lua-ftplugin', {['for'] = 'lua'})

-- depedencies
Plug 'xolox/vim-misc'
--------------------------------------------------------------------------------

-- scala
Plug ('derekwyatt/vim-scala', {['for'] = 'scala'})
--------------------------------------------------------------------------------

-- cpp
Plug ('octol/vim-cpp-enhanced-highlight', {['for'] = 'cpp'})

-- switch from header file to cpp file (vice versa)
Plug ('ericcurtin/CurtineIncSw.vim', {['for'] = {'cpp', 'c'}})

-- Qt support
Plug ('fedorenchik/qt-support.vim', {['for'] = 'cpp'})
--------------------------------------------------------------------------------

-- julia
Plug ('JuliaEditorSupport/julia-vim', {['for'] = 'julia'})
--------------------------------------------------------------------------------

-- Colorschemes
Plug 'ajmwagar/vim-deus'
Plug 'morhetz/gruvbox'
--------------------------------------------------------------------------------

vim.call('plug#end')
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- General configs
vim.cmd 'syntax on' -- syntax highlighting, see :help syntax
vim.cmd 'filetype plugin indent on' -- file type detection, see :help filetype
vim.opt.number = true -- display line number
vim.opt.path:append('**') -- improves searching, see :help path
vim.opt.swapfile = false -- disable use of swap files
vim.opt.wildmenu = true -- completion menu
vim.opt.backspace = 'indent,eol,start' -- ensure proper backspace functionality
vim.opt.undofile = true -- see :help undodir and :help undofile
vim.opt.incsearch = true -- see results while search is being typed, see :help incsearch
vim.opt.smartindent = true -- auto indent on new lines, see :help smartindent
vim.opt.ic = true -- ignore case when searching
vim.opt.colorcolumn = '80' -- display color when line reaches pep8 standards
vim.opt.expandtab = true  -- expanding tab to spaces
vim.opt.tabstop = 4 -- setting tab to 4 columns
vim.opt.shiftwidth = 4 -- setting tab to 4 columns
vim.opt.softtabstop = 4 -- setting tab to 4 columns
vim.opt.showmatch = true -- display matching bracket or parenthesis
vim.opt.hlsearch = true -- highlight all pervious search pattern with incsearch
vim.opt.foldmethod = 'indent' -- use indentation to create folds
vim.opt.wrap = false -- no wrap lines

-- New Leader Key
vim.g.mapleader = ','

-- Colorscheme
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd 'colorscheme gruvbox'

-- Map key to show a List of Buffers
vim.keymap.set('n', '<Leader>b', ':buffers<CR>')

-- Copy and Paste facilities
vim.keymap.set('v', '<Leader>y', '"+y')
vim.keymap.set('n', '<Leader>p', '"+p')

-- Keybind Ctrl+l to clear search
vim.keymap.set('n', '<C-l>', function ()
	vim.cmd('nohl')
	print('Search cleared')
end, {noremap = true})
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Plugins Config

-- Vim-markdown-preview
vim.g.vim_markdown_preview_use_xdg_open = true
vim.g.vim_markdown_preview_github = true

-- Dart-vim-plugin config
vim.g.dart_format_on_save = true
vim.g.dart_style_guide = true
vim.g.dart_trailing_comma_indent = true
vim.g.dart_html_in_string = true

-- Go Fmt keep folding
vim.g.go_fmt_experimental = true

-- CurtineIncSw config (switch between header and cpp file)
--map <Leader>s :call CurtineIncSw()<CR>
vim.keymap.set('', '<Leader>s', function ()
    vim.call('CurtineIncSw')
    print('Swap header/cpp')
end)

-- enable matchit plugin for julia blocks
vim.cmd('runtime macros/matchit.vim')

-- enable spell on text files
vim.api.nvim_create_autocmd('Filetype', {
    pattern = 'markdown,text',
    command = 'setlocal spell',
})

-- COQ (auto-completion)
vim.g.coq_settings = {
    auto_start = true,
}

-- neovim init autogroup
local augroup_config = vim.api.nvim_create_augroup('config', {clear = true})

-- LSP configuration
local lsp = require('lspconfig')
-- using coq to support LSP snippets
local coq = require('coq')

local on_attach = function(client, bufnr)
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup_config,
      buffer = bufnr,
      callback = function() vim.lsp.buf.format() end
    })
  end
end

-- pylsp - python
lsp.pylsp.setup(coq.lsp_ensure_capabilities{
    on_attach = on_attach,
    settings = {
        pylsp = {
            plugins = {
                pylint = {
                    enabled = false,
                },
                pydocstyle = {
                    enabled = true,
                },
            }
        }
    }
})
-- pyright - python
lsp.pyright.setup(coq.lsp_ensure_capabilities{
    on_attach = on_attach
})

-- ccls - c/cpp
lsp.ccls.setup(coq.lsp_ensure_capabilities{
    on_attach = on_attach
})

-- golsp - golang
lsp.gopls.setup(coq.lsp_ensure_capabilities{
    on_attach = on_attach
})

-- tsserver - typescript
lsp.tsserver.setup(coq.lsp_ensure_capabilities{
    on_attach = on_attach
})

-- angularls - angularjs
lsp.angularls.setup(coq.lsp_ensure_capabilities{
    on_attach = on_attach
})

-- ltex-ls - languagetool lsp
lsp.ltex.setup(coq.lsp_ensure_capabilities{
    on_attach = on_attach,
    settings = {
        ltex = {
            language = 'auto',
        },
    },
})

-- hotkeys
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- vim-pydocstring
vim.g.pydocstring_formatter = 'google'
vim.g.pydocstring_ignore_init = true
vim.keymap.set('n', '<Leader>d', '<Plug>(pydocstring)', {silent = true})

-- run isort to organize imports after save
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.py',
    group = augroup_config,
    command = 'undojoin | silent !isort %',
})
