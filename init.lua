--******************************************************************************
-- Plugins installation
--******************************************************************************
local Plug = vim.fn['plug#']
vim.call('plug#begin')

-- General Plugins

-- nvim-tree - Tree Explorer
Plug 'nvim-tree/nvim-tree.lua'
-- depedencies:
Plug 'nvim-tree/nvim-web-devicons'

-- status line
Plug 'nvim-lualine/lualine.nvim'

-- git plugin
Plug 'tpope/vim-fugitive'

-- fuzzy search
Plug ('nvim-telescope/telescope.nvim', { branch = '0.1.x' })
-- depedencies:
Plug 'nvim-lua/plenary.nvim'

-- comment plugin - <Leader>cc <Leader>cu
Plug 'scrooloose/nerdcommenter'

-- make gvim-only colorschemes work in terminal
Plug 'vim-scripts/CSApprox'

-- trailing whitespace
Plug 'axelf4/vim-strip-trailing-whitespace'

-- open files in the last place
Plug 'farmergreg/vim-lastplace'
--------------------------------------------------------------------------------

-- Language Server Protocol
Plug 'neovim/nvim-lspconfig'
--------------------------------------------------------------------------------

-- Autocompletion nvim-cmp
Plug 'hrsh7th/nvim-cmp'

-- sources for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

-- LuaSnip - snippet plugin
Plug ('L3MON4D3/LuaSnip', {tag = 'v2.*', ['do'] = 'make install_jsregexp'})
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
--------------------------------------------------------------------------------

-- Python
Plug ('heavenshell/vim-pydocstring',
    {['for'] = 'python', ['do'] = 'make install'})
--------------------------------------------------------------------------------

-- Golang
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
--------------------------------------------------------------------------------

-- Typescript
Plug ('leafgarland/typescript-vim', {['for'] = 'typescript'})

-- JSX
Plug ('MaxMEllon/vim-jsx-pretty', {['for'] = 'javascript, typescript'})
--------------------------------------------------------------------------------

-- Html, Jinja and templates
Plug ('lepture/vim-jinja', {['for'] = 'html.jinja'})
--------------------------------------------------------------------------------

-- Emmet - write html fast
-- <C-Y>,
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

-- Colorscheme
Plug 'joshdick/onedark.vim'
--------------------------------------------------------------------------------

vim.call('plug#end')
--******************************************************************************

--******************************************************************************
-- General configs
--******************************************************************************
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
vim.opt.colorcolumn = '81' -- display color when line reaches pep8 standards
vim.opt.expandtab = true  -- expanding tab to spaces
local tab_size = 2
vim.opt.tabstop = tab_size
vim.opt.shiftwidth = tab_size
vim.opt.softtabstop = tab_size
vim.opt.showmatch = true -- display matching bracket or parenthesis
vim.opt.hlsearch = true -- highlight all pervious search pattern with incsearch
vim.opt.foldmethod = 'indent' -- use indentation to create folds
vim.opt.wrap = false -- no wrap lines

-- Colorscheme
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd 'colorscheme onedark'

-- New Leader Key
vim.g.mapleader = ','

-- Map key to show a List of Buffers
vim.keymap.set('n', '<Leader>b', ':buffers<CR>', { desc = 'List all buffers'})

-- Copy and Paste facilities
vim.keymap.set('v', '<Leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<Leader>p', '"+p', { desc = 'Paste from system clipboard' })

-- Keybind Ctrl+l to clear search
vim.keymap.set('n', '<C-l>', function ()
	vim.cmd('nohl')
	print('Search cleared')
end, {noremap = true, desc = 'Clear search highlight'})

-- neovim init autogroup
local augroup_config = vim.api.nvim_create_augroup('config', {clear = true})
--******************************************************************************

--******************************************************************************
-- Autocompletions config
--******************************************************************************

-- Set up nvim-cmp.
local cmp = require('cmp')
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        --completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to only confirm
        -- explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For vsnip users.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

--******************************************************************************
-- LSP config
--******************************************************************************

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP configuration
local lsp = require('lspconfig')

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

-- angularls - angularjs
-- npm install -g @angular/language-server
lsp.angularls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- ccls - c/cpp
-- yay -S ccls
lsp.ccls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- gopls - golang
-- go install golang.org/x/tools/gopls@latest
lsp.gopls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- ltex-ls - languagetool lsp
-- yay -S ltex-ls-bin
lsp.ltex.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ltex = {
            language = 'auto',
        },
    },
}

-- pylsp - python
-- pipx install 'python-lsp-server[all]'
lsp.pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
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
    },
}

-- pyright - python
-- pipx install pyright
lsp.pyright.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- tsserver - typescript
-- sudo npm install -g typescript typescript-language-server
lsp.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- LSP hotkeys
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
function get_diagnostic_opts(desc)
    return { desc = 'Diagnostic: ' .. desc }
end
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float,
    get_diagnostic_opts('Open floating list'))
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
    get_diagnostic_opts('Go to previous'))
vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
    get_diagnostic_opts('Go to next'))
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist,
    get_diagnostic_opts('Add to loclist'))

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    function get_opts(desc)
        local opts = { buffer = ev.buf, desc = 'LSP: ' .. desc}
    end

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, get_opts('go to declaration'))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, get_opts('go to definition'))
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, get_opts('info about the symbol'))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, get_opts('go to implementation'))
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, get_opts('display signature info'))
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, get_opts(''))
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, get_opts(''))
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, get_opts(''))
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, get_opts('go to type definition'))
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, get_opts('rename references to the symbol'))
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, get_opts('select a code action'))
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, get_opts('list all references'))
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, get_opts('autoformat'))
  end,
})

--******************************************************************************
-- Plugins Config
--******************************************************************************

-- Dart-vim-plugin config
vim.g.dart_format_on_save = true
vim.g.dart_style_guide = true
vim.g.dart_trailing_comma_indent = true
vim.g.dart_html_in_string = true

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

-- nvim-tree config
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup({
    view = {
        width = 40,
    },
    renderer = {
        full_name = true,
    },
    diagnostics = {
        enable = true,
    },
    tab = {
        sync = {
            open = true,
            close = true,
        },
    },
})

-- set mapping <C-n> to show/close
vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<CR>',
  { desc = 'Open Tree Explorer' })
-- set mapping <C-m> to focus
vim.keymap.set('n', '<C-m>', ':NvimTreeFocus<CR>',
  { desc = 'Focus on Tree Explorer' })

-- lualine config
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- luasnip config
-- load snippets from custom paths
require("luasnip.loaders.from_vscode").lazy_load()
require('luasnip.loaders.from_snipmate').lazy_load()

-- mapping
vim.keymap.set({"i"}, "<C-k>", function() luasnip.expand() end,
  {silent = true, desc = 'Expand snippet'})
vim.keymap.set({"i", "s"}, "<C-l>", function() luasnip.jump(1) end,
  {silent = true, desc = 'Jump to next snippet entry'})
vim.keymap.set({"i", "s"}, "<C-j>", function() luasnip.jump(-1) end,
  {silent = true, desc = 'Jump to previous snippet entry'})
vim.keymap.set({"i", "s"}, "<C-e>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end, {silent = true, desc = 'Close snippet choices'})

-- fuzzy search telescope config
local telescope_builtin = require('telescope.builtin')
function ff_opts(desc)
  return { desc = 'Fuzzy search: ' .. desc }
end
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files,
  ff_opts('Find files'))
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep,
  ff_opts('Live grep'))
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers,
  ff_opts('List buffers'))
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags,
  ff_opts('Help tags'))
vim.keymap.set('n', '<leader>fp', telescope_builtin.builtin,
  ff_opts('List builtin pickers'))
vim.keymap.set('n', '<leader>fk', telescope_builtin.keymaps,
  ff_opts('List keymaps'))
vim.keymap.set('n', '<leader>fm', telescope_builtin.man_pages,
  ff_opts('Search man pages'))
vim.keymap.set('n', '<leader>fs', telescope_builtin.grep_string,
  ff_opts('Grep string'))
--******************************************************************************
