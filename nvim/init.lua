vim.opt.shell = '/bin/bash'
vim.g.mapleader = ' '
vim.cmd[[
	filetype off
	set nocompatible
]]

-- For easier remapping keys 
local map = function(key)
  -- get the extra options
  local opts = {noremap = true}
  for i, v in pairs(key) do
    if type(i) == 'string' then opts[i] = v end
  end

  -- basic support for buffer-scoped keybindings
  local buffer = opts.buffer
  opts.buffer = nil

  if buffer then
    vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
  else
    vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
  end
end

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

-- VIM enhancements
Plug 'ciaranm/securemodelines'
Plug 'vim-scripts/localvimrc'
Plug 'justinmk/vim-sneak'
Plug 'kshenoy/vim-signature'
Plug 'schickling/vim-bufonly'
Plug 'bitc/vim-bad-whitespace'
Plug 'kbknapp/badWords'
Plug 'romgrk/nvim-treesitter-context'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug 'nvim-treesitter/playground'
Plug 'godlygeek/tabular'
Plug 'folke/which-key.nvim'
Plug 'tpope/vim-repeat' -- Repeat all commands with . not just native
Plug 'simeji/winresizer' -- Better window resizing with Ctrl+E"

-- GUI enhancements
Plug 'hoob3rt/lualine.nvim'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'

-- Visualize your Undo Tree
--     -> :GundoToggle           See Undo Tree
Plug 'sjl/gundo.vim'

-- Files / Coding
Plug 'kyazdani42/nvim-web-devicons' -- for file icons
Plug 'kyazdani42/nvim-tree.lua'     -- better NERDTree
Plug 'moll/vim-bbye' -- Better Buffer Close support (don't wipe out splits, etc.)
Plug 'airblade/vim-rooter' -- Find project root
Plug 'simrat39/symbols-outline.nvim' -- Tagbar replacement

-- Languages
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
--Plug 'Maverun/telescope-snippets'
Plug 'norcalli/snippets.nvim'
Plug 'windwp/nvim-spectre'              -- Search and Replace
Plug 'mitchellh/tree-sitter-hcl'
-- Plug 'hrsh7th/vim-vsnip'             -- Snippet handling
Plug 'saadparwaiz1/cmp_luasnip'
-- Plug 'hrsh7th/vim-vsnip'
-- Plug 'hrsh7th/vim-vsnip-integ'
Plug 'L3MON4D3/LuaSnip'
Plug '~/Projects/telescope-luasnip'
--Plug 'fhill2/telescope-ultisnips.nvim'
--Plug 'SirVer/ultisnips'
--Plug 'honza/vim-snippets'   -- Actual snippets for UltiSnip
Plug 'rafamadriz/friendly-snippets'

-- Zig
Plug 'ziglang/zig.vim'
Plug 'zigtools/zls'                    -- Zig

-- Rust
Plug 'mhinz/vim-crates'
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'        -- Rust
--Plug 'racer-rust/vim-racer'

-- nvim-lsp based
Plug 'neovim/nvim-lspconfig'           -- Common configuration
Plug 'nvim-lua/lsp_extensions.nvim'    -- type inlay hints, etc
Plug 'ray-x/lsp_signature.nvim'        -- Function signatures
Plug 'hrsh7th/nvim-cmp'                -- Autocompletion
Plug 'hrsh7th/cmp-buffer'
Plug 'onsails/lspkind-nvim'
--Plug 'nvim-lua/completion-nvim'
--Plug 'steelsojka/completion-buffers'
--Plug 'nvim-treesitter/completion-treesitter'
Plug 'hrsh7th/cmp-nvim-lsp'

-- Semantic language support
-- Plug 'ncm2/ncm2'
-- Plug 'roxma/nvim-yarp'

-- Comment or UN-Comment Code
--    -> gcc                  Comment or uncomment line(s)
Plug 'b3nj5m1n/kommentary'

-- Better surround support
--     -> cs"'     "Hello"->'Hello'
--     -> ysiw[   'Hello'->[Hello]
--     -> ds[     [Hello]->Hello
-- Plug 'tpope/vim-surround'
-- Better surround support
--     -> s{act}{obj}{item}
--     --> a=add, d=delete, r=replace
--     --> obj is text object
--     --> item is the surround
--     -> saiw'     Hello->'Hello'
--     -> srb[   'Hello'->[Hello]
--     -> sd[     [Hello]->Hello
Plug 'machakann/vim-sandwich'

-- Markdown
Plug 'mzlogin/vim-markdown-toc'
Plug 'plasticboy/vim-markdown'
Plug('junegunn/goyo.vim', {['for'] = 'markdown'})

-- Git Plugins
-- Plug 'TimUntersberger/neogit'

-- +,-,~ in gutter
Plug 'airblade/vim-gitgutter'

-- TOML
Plug 'cespare/vim-toml'

-- Go
Plug 'fatih/vim-go'

-- Fish
Plug 'dag/vim-fish'

-- Colorscheme
Plug('folke/tokyonight.nvim', {['branch'] = 'main'})

Plug 'chrisbra/unicode.vim'

vim.call('plug#end')

require("which-key").setup { }

-- Crates.io
vim.cmd [[
  autocmd BufRead Cargo.toml call crates#toggle()
]]

-- Gundo
map {'n', '<C-u>', ':GundoToggle<CR>'}
vim.opt.undofile = true     -- persist the undo-tree between sessions
vim.opt.undolevels = 100
if vim.fn.has('python3') == 1 then
    vim.g.gundo_prefer_python3 = true
end

-- Kommentary
map {'n', '<C-/>', 'gcc'}

-- Pull up magit
map {'n', '<leader>gg', ':silent ! emacs -e magit-status &<CR>'}

-- Tabular
map {'n', '<leader>t=', ':Tab /=<CR>'}
map {'v', '<leader>t=', ':Tab /=<CR>'}
map {'n', '<leader>t"', ':Tab /=<CR>'}
map {'v', '<leader>t"', ':Tab /=<CR>'}
map {'n', "<leader>t'", ':Tab /=<CR>'}
map {'v', "<leader>t'", ':Tab /=<CR>'}
map {'n', '<leader>t:', ':Tab /:\\zs<CR>'}
map {'v', '<leader>t:', ':Tab /:\\zs<CR>'}

-- Telescope
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

require('telescope').load_extension('luasnip')

map {'n', '<leader>ff', '<cmd>Telescope find_files<CR>'}
map {'n', '<C-p>', '<cmd>Telescope find_files<CR>'}
map {'n', '<leader>/', '<cmd>Telescope live_grep<CR>'}
map {'n', '<leader>fg', '<cmd>Telescope live_grep<CR>'}
map {'n', '<leader>ss', '<cmd>Telescope live_grep<CR>'}
map {'n', '<leader>sn', '<cmd>Telescope luasnip<CR>'}
map {'n', '<leader>fb', '<cmd>Telescope buffers<CR>'}
map {'n', '<leader>bb', '<cmd>Telescope buffers<CR>'}
map {'n', '<leader>fh', '<cmd>Telescope help_tags<CR>'}
map {'n', '<leader>ft', '<cmd>Telescope tags<CR>'}
map {'n', '<leader>fm', '<cmd>Telescope marks<CR>'}
map {'n', '<leader>fr', '<cmd>Telescope registers<CR>'}
map {'n', '<leader>fe', '<cmd>Telescope lsp_document_diagnostics<CR>'}
map {'n', '<leader>fee', '<cmd>Telescope lsp_workspace_documents<CR>'}

-- Spectre
map {'n', '<leader>sr', '<cmd>lua require("spectre").open()<CR>'}
map {'n', '<leader>srw', "<cmd>lua require('spectre').open_visual({select_word=true})<CR>"} -- search current word
map {'n', '<leader>sb', "<cmd>lua require('spectre').open_file_search()<cr>"}  -- search in current file
map {'v', '<leader>r', "<cmd>lua require('spectre').open_visual()<CR>"}

-- Configuration for vim-markdown / Goyo
vim.g.vim_markdown_auto_insert_bullets = false
vim.g.vim_markdown_autowrite = true
vim.g.vim_markdown_conceal = 2
vim.g.vim_markdown_conceal_code_blocks = false
vim.g.vim_markdown_edit_url_in = 'tab'
vim.g.vim_markdown_fenced_languages = {'rust=rs'}
vim.g.vim_markdown_follow_anchor = true
vim.g.vim_markdown_frontmatter = true
vim.g.vim_markdown_math = true
vim.g.vim_markdown_new_list_item_indent = false
vim.g.vim_markdown_strikethrough = true
vim.g.vim_markdown_toml_frontmatter = true

-- nvim-tree
map {'n', '<C-n>', ':NvimTreeToggle<CR>'}
map {'n', '<leader>r', ':NvimTreeRefresh<CR>'}
map {'n', '<leader>n', ':NvimTreeFindFile<CR>'}

vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache', 'target' } -- empty by default
vim.g.nvim_tree_gitignore = true
vim.g.nvim_tree_auto_close = true -- closes the tree when it's the last window
vim.g.nvim_tree_indent_markers = true  -- shows indent markers when folders are open
vim.g.nvim_tree_hide_dotfiles = true -- hides files and folders starting with a dot `.`
vim.g.nvim_tree_git_hl = true -- will enable file highlight for git attributes (can be used without the icons).
vim.g.nvim_tree_highlight_opened_files = true -- will enable folder and file icon highlight for opened files/directories.
vim.g.nvim_tree_add_trailing = true -- append a trailing slash to folder names
vim.g.nvim_tree_group_empty = true -- compact folders that only contain a single folder into one node in the file tree
vim.g.nvim_tree_lsp_diagnostics = true -- will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
vim.g.nvim_tree_hijack_cursor = false -- when moving cursor in the tree, position the cursor at the start of the file on the current line

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')
local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        require('completion').on_attach()
	require("lsp_signature").on_attach()
end

local servers = {'zls'}
for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            on_attach = on_attach,
	    capabilities = capabilities,
        }
end

require "lsp_signature".setup()

-- nvim-cmp
local lspkind = require('lspkind')
local cmp = require'cmp'.setup({
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'buffer', name = 'luasnip', name = 'nvim_lsp' },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
      })[entry.source.name]
      return vim_item
    end
  },
})

-- LuaSnip

local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end

local luasnip = prequire('luasnip')

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif luasnip and luasnip.expand_or_jumpable() then
        return t "<Plug>luasnip-expand-or-jump"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return cmp.complete()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif luasnip and luasnip.jumpable(-1) then
        return t "<Plug>luasnip-jump-prev"
    else
        return t "<S-Tab>"
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

-- Load predefined LSP snippets
require("luasnip/loaders/from_vscode").load({
	paths = {
		'~/.config/nvim/snippets/',
		'~/.config/nvim/plugged/friendly-snippets/'}
	}
)

-- Enable faster viewport scrolling
map {'n', '<C-e>', '8<C-e>'}
map {'n', '<C-y>', '8<C-y>'}

-- Mirror CLion for tags and jumps
map {'n', '<C-b>', '<C-]>'}
-- C-BS doesn't work in Terminal VIM: https://vim.fandom.com/wiki/Map_Ctrl-Backspace_to_delete_previous_word
map {'n', "<C-'>", '<C-O>'}

-- Open hotkeys
map {'n', '<leader>bp', ':bp<CR>', noremap = false}
map {'n', '<leader>bn', ':bn<CR>', noremap = false}
map {'n', '<leader>bw', ':Bwipeout!<CR>', noremap = false}
map {'n', '<leader>bk', ':Bdelete!<CR>', noremap = false}
map {'n', '<leader>bW', ':wa :bufdo :Bwipeout!<CR>', noremap = false}
-- Close all buffers but re-open the most recent...i.e. all but current one
map {'n', '<leader>bK', ':wa :%bdelete!<CR><C-O>:Bd#<CR>', noremap = false}

-- Quick-save
map {'n', '<leader>w', ':w<CR>', noremap = false}

-- Code navigation shortcuts as found in :help lsp 
-- (<silent>?)
map {'n', "<c-]>", '<cmd>lua vim.lsp.buf.definition()<CR>'}
map {'n', "<leader>cd", '<cmd>lua vim.lsp.buf.definition()<CR>'}
map {'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>'}
map {'n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>'}
map {'n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>'}
map {'n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>'}
map {'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>'}
map {'n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>'}
map {'n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>'}
-- rust-analyzer does not yet support goto declaration
-- re-mapped `gd` to definition
map {'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>'}
-- Goto previous/next diagnostic warning/error
map {'n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>'}
map {'n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>'}


-- Rust Language Support
require('rust-tools').setup({
    tools = { -- rust-tools options
        -- automatically set inlay hints (type hints)
        -- There is an issue due to which the hints are not applied on the first
        -- opened file. For now, write to the file to trigger a reapplication of
        -- the hints or just run :RustSetInlayHints.
        -- default: true
        autoSetHints = true,

        -- whether to show hover actions inside the hover window
        -- this overrides the default hover handler
        -- default: true
        hover_with_actions = true,

        runnables = {
            -- whether to use telescope for selection menu or not
            -- default: true
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        inlay_hints = {
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<-",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix  = "=>",

            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              {"╭", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╮", "FloatBorder"},
              {"│", "FloatBorder"},
              {"╯", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╰", "FloatBorder"},
              {"│", "FloatBorder"}
            },
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {}, -- rust-analyer options
})

vim.cmd[[colorscheme tokyonight]]
vim.g.tokyonight_style = "night"

-- LuaLine
require('lualine').setup {
  options = {
    theme = 'tokyonight'
  }
}

-- Symbols-Outline (Tagbar)
map {'n', '<C-s>', ':SymbolsOutline<CR>'}
map {'n', '<leader>o', ':SymbolsOutline<CR>'}
vim.g.symbols_outline = {
    highlight_hovered_item = false,
    show_guides = true,
    auto_preview = false,
    show_symbol_details = true,
    keymaps = {
        close = {"<Esc>", "q"},
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
    symbols = {
        File = {icon = "", hl = "TSURI"},
        Module = {icon = "", hl = "TSNamespace"},
        Namespace = {icon = "", hl = "TSNamespace"},
        Package = {icon = "📦", hl = "TSNamespace"},
        Class = {icon = "ﴯ", hl = "TSType"},
        Method = {icon = "ƒ", hl = "TSMethod"},
        Property = {icon = "ﰠ", hl = "TSMethod"},
        Field = {icon = "α", hl = "TSField"},
        Constructor = {icon = "", hl = "TSConstructor"},
        Enum = {icon = "∑", hl = "TSType"},
        Interface = {icon = "", hl = "TSType"},
        Function = {icon = "ƒ", hl = "TSFunction"},
        Variable = {icon = "α", hl = "TSConstant"},
        Constant = {icon = "π", hl = "TSConstant"},
        String = {icon = "", hl = "TSString"},
        Number = {icon = "#", hl = "TSNumber"},
        Boolean = {icon = "⊨", hl = "TSBoolean"},
        Array = {icon = "", hl = "TSConstant"},
        Object = {icon = "⦿", hl = "TSType"},
        Key = {icon = "🔑", hl = "TSType"},
        Null = {icon = "␀", hl = "TSType"},
        EnumMember = {icon = "σ", hl = "TSField"},
        Struct = {icon = "𝓢", hl = "TSType"},
        Event = {icon = "", hl = "TSType"},
        Operator = {icon = "", hl = "TSOperator"},
        TypeParameter = {icon = "T", hl = "TSParameter"}
    }
}

-- lspkind
require('lspkind').init({
    -- enables text annotations
    with_text = true,
    -- override preset symbols
    symbol_map = {
      Text = "",
      Method = "",
      Function = "ƒ",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "∑",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "σ",
      Constant = "",
      Struct = "𝓢",
      Event = "",
      Operator = "",
      TypeParameter = "T"
    },
})
-- Source existing nvim config
vim.cmd 'source ~/.config/nvim/legacy-init.vim'


