vim.opt.shell = '/bin/zsh'
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
Plug 'roosta/fzf-folds.vim'
Plug 'ggandor/lightspeed.nvim'
Plug 'andymass/vim-matchup'
Plug 'hoob3rt/lualine.nvim'
Plug 'machakann/vim-highlightedyank' -- keep yanked highlighted
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
-- Plug 'norcalli/snippets.nvim'
Plug 'windwp/nvim-spectre'         -- Search and Replace
Plug 'mitchellh/tree-sitter-hcl'
-- Plug 'L3MON4D3/LuaSnip'
-- Plug '~/Projects/telescope-luasnip'
-- Plug 'rafamadriz/friendly-snippets'

-- Colorscheme
Plug('folke/tokyonight.nvim', {['branch'] = 'main'})
Plug 'navarasu/onedark.nvim'

Plug 'chrisbra/unicode.vim'

-- Visualize your Undo Tree
--     -> :GundoToggle           See Undo Tree
Plug 'sjl/gundo.vim'

-- Files / Coding
Plug 'kyazdani42/nvim-web-devicons'  -- for file icons
Plug 'kyazdani42/nvim-tree.lua'      -- better NERDTree
Plug 'moll/vim-bbye'                 -- Better Buffer Close support (don't wipe out splits, etc.)
Plug 'airblade/vim-rooter'           -- Find project root
Plug 'simrat39/symbols-outline.nvim' -- Tagbar replacement
Plug 'mfussenegger/nvim-dap'

-- Languages
-- Python
Plug('neoclide/coc.nvim', {['branch'] = 'release', ['for'] = 'python' })
Plug('mfussenegger/nvim-dap-python', {['for'] = 'python'})

-- Zig
Plug('ziglang/zig.vim', {['for'] = 'zig'})
Plug('zigtools/zls', {['for'] = 'zig'})

-- Rust
Plug('mhinz/vim-crates', {['for'] = 'rust'})
Plug('rust-lang/rust.vim', {['for'] = 'rust'})
Plug 'simrat39/rust-tools.nvim'
--Plug 'racer-rust/vim-racer'

-- nvim-lsp based
--Plug 'saadparwaiz1/cmp_luasnip'
Plug 'neovim/nvim-lspconfig'           -- Common configuration
Plug 'nvim-lua/lsp_extensions.nvim'    -- type inlay hints, etc
Plug 'ray-x/lsp_signature.nvim'        -- Function signatures
Plug 'hrsh7th/nvim-cmp'                -- Autocompletion framework
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'               -- Snippet completion
Plug 'hrsh7th/vim-vsnip'               -- Snippet Engine
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/cmp-nvim-lsp'            -- LSP Completion
Plug 'folke/trouble.nvim'              -- LSP Diagnostics

-- Comment or UN-Comment Code
--    -> gcc                  Comment or uncomment line(s)
Plug 'b3nj5m1n/kommentary'

-- Better surround support
--     -> cs"'     "Hello"->'Hello'
--     -> ysiw[   'Hello'->[Hello]
--     -> ds[     [Hello]->Hello
Plug 'tpope/vim-surround'

-- Markdown
Plug('mzlogin/vim-markdown-toc', {['for'] = 'markdown'})
Plug('plasticboy/vim-markdown', {['for'] = 'markdown'})

-- Leetcode Client
Plug 'ianding1/leetcode.vim'

-- Git
Plug 'airblade/vim-gitgutter' -- +,-,~ in gutter
Plug 'f-person/git-blame.nvim' -- Blame

-- TOML
Plug('cespare/vim-toml', {['for'] = 'toml'})

-- Go
Plug('fatih/vim-go', {['for'] = 'go'})

vim.call('plug#end')

require("which-key").setup()

-- python-dap
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='🟢', texthl='', numhl=''})

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

-- Folds
map {'n', '<leader>zz', ':set foldmethod=syntax<cr>', silent = true }
map {'n', '<leader>fz', ':Folds<cr>'}

-- Kommentary
require('kommentary.config').configure_language("rust", {
    prefer_single_line_comments = true,
})
map {'n', '<C-/>', 'gcc'}

-- Leetcode
vim.g.leetcode_browser = 'firefox'
vim.g.leetcode_solution_filetype = 'rust'
vim.g.leetcode_hide_paid_only = 1

-- Pull up magit
map {'n', '<leader>gg', ':silent ! emacs -e magit-status &<CR>'}

-- Surround
vim.g.surround_no_mappings = 1
map {'n', 'ds', '<Plug>Dsurround'}
map {'n', 'cs', '<Plug>Csurround'}
map {'n', 'cS', '<Plug>CSurround'}
map {'n', 'ys', '<Plug>Ysurround'}
map {'n', 'yS', '<Plug>YSurround'}
map {'n', 'yss', '<Plug>Yssurround'}
map {'n', 'ySs', '<Plug>YSsurround'}
map {'n', 'ySS', '<Plug>YSSurround'}
map {'n', 'gs', '<Plug>VSurround'}
map {'n', 'gS', '<Plug>VgSurround'}

-- Tabular
map {'n', '<leader>t=', ':Tab /=<CR>'}
map {'v', '<leader>t=', ':Tab /=<CR>'}
map {'n', '<leader>t"', ':Tab /=<CR>'}
map {'v', '<leader>t"', ':Tab /=<CR>'}
map {'n', "<leader>t'", ':Tab /=<CR>'}
map {'v', "<leader>t'", ':Tab /=<CR>'}
map {'n', '<leader>t:', ':Tab /:\\zs<CR>'}
map {'v', '<leader>t:', ':Tab /:\\zs<CR>'}

-- Trouble
require("trouble").setup { }
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
map {'n', '<leader>ee', ':TroubleToggle<CR>'}
map {'n', '<leader>ed', ':TroubleToggle document_diagnostics<CR>'}
map {'n', '<leader>ew', ':TroubleToggle workspace_diagnostics<CR>'}
map {'n', '<leader>eq', ':TroubleToggle quickfix<CR>'}
map {'n', '<leader>el', ':TroubleToggle loclist<CR>'}
map {'n', '<leader>eL', ':TroubleToggle lsp_references<CR>'}

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
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    }
  }
}

require('telescope') -- .load_extension('luasnip')

map {'n', '<leader>ff', '<cmd>Telescope find_files<CR>'}
map {'n', '<C-p>', '<cmd>Telescope find_files<CR>'}
map {'n', '<leader>/', '<cmd>Telescope live_grep<CR>'}
map {'n', '<leader>fg', '<cmd>Telescope live_grep<CR>'}
map {'n', '<leader>ss', '<cmd>Telescope live_grep<CR>'}
-- map {'n', '<leader>sn', '<cmd>Telescope luasnip<CR>'}
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

require'nvim-tree'.setup({
  -- will show lsp diagnostics in the signcolumn.
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  -- when moving cursor in the tree, position the cursor at the start of the file on the current line
  hijack_cursor = false,
  renderer = {
    -- will enable folder and file icon highlight for opened files/directories.
    highlight_opened_files = "name",
    -- compact folders that only contain a single folder into one node in the file tree
    group_empty = true,
    -- will enable file highlight for git attributes (can be used without the icons).
    highlight_git = true,
    -- append a trailing slash to folder names
    add_trailing = true,
    indent_markers = {
	enable = true,
    }
  },
})

-- nvim_lsp Setup

local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)

map {'n', 'le', ':RustExpandMacro<cr>'}
map {'n', 'lh', ':RustToggleInlayHints<cr>'}

-- Completion Setup

local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }), -- from rust-tools
    -- ['<C-Space>'] = cmp.mapping.complete(), -- from cmp-vnsip
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    --[[ ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }) ]]
  },

  -- Sources
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
})

require "lsp_signature".setup()

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
    --[[ elseif luasnip and luasnip.jumpable(-1) then
        return t "<Plug>luasnip-jump-prev" ]]
    else
        return t "<S-Tab>"
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
--[[ vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {}) ]]

-- Load predefined LSP snippets
--[[ require("luasnip/loaders/from_vscode").load({
	paths = {
		'~/.config/nvim/snippets/',
		'~/.config/nvim/plugged/friendly-snippets/'}
	}
)
 ]]
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

-- Always run rustfmt is applicable and always use stable.
vim.g.rustfmt_autosave_if_config_present = 1
vim.g.rustfmt_command = "rustfmt +stable"

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

-- Options dark, darker, cool, deep, warm, warmer
require('onedark').setup {
    style = 'dark'
}
require('onedark').load()
--vim.cmd[[colorscheme tokyonight]]
--vim.g.tokyonight_style = "night"

-- LuaLine
vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
vim.g.gitblame_date_format = '%r'

local git_blame = require('gitblame')

require('lualine').setup {
  options = {
    theme = 'tokyonight'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diff', 'diagnostics'},
    lualine_c = {
      { 'filename', path = 1},
      { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
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
--[[ require('lspkind').init({
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
}) ]]

-- Neovide Settings
vim.g.neovide_cursor_vfx_mode = "railgun"

-- Toggle cursor line
map {'n', '<leader>hl', ':set cursorline! cursorcolumn!<CR>'}

-- Keybindings
--
-- Suspend with Ctrl+f
map {'i', '<C-f>', ':sus<cr>'}
map {'v', '<C-f>', ':sus<cr>'}
map {'n', '<C-f>', ':sus<cr>'}

-- Jump to start and end of line using the home row keys
map {'n', 'H', '^'}
map {'n', 'L', '$'}

-- Use jj or kj as ESC
map {'i', 'kj', '<Esc>'}
map {'i', 'jj', '<Esc>'}

-- Move by visual line
map {'n', 'j', 'gj'}
map {'n', 'k', 'gk'}

-- toggles between buffers
map {'n', '<leader><leader>', '<c-^>'}

-- shows/hides hidden characters
map {'n', '<leader>,', ':set invlist<cr>'}

--  shows stats
map {'n', '<leader>q', 'g<c-g>'}

-- arrows can switch buffers/tabs
map {'n', '<left>', ':tp<CR>'}
map {'n', '<right>', ':tn<CR>'}
map {'n', '<up>', ':bp<CR>'}
map {'n', '<down>', ':bn<CR>'}

-- Edit/Source the config
map {'n', '<leader>sec', ':e ~/.config/nvim/init.lua<CR>'}
map {'n', '<leader>sc', ':e ~/.config/nvim/init.lua<CR>'}

-- Terminal Mode
map {'n', '<C-t>', ':terminal<CR>'}
map {'i', '<C-t>', ':terminal<CR>'}
map {'n', '<leader>oe', ':terminal<CR>'}

-- Use ESC normally
map {'t', '<Esc>', '<C-\\><C-n>'}
map {'t', '<leader>bp', ':bp<CR>'}
map {'t', '<leader>bk', ':Bwipeout!<CR>:e#<CR>'}

-- CTRL+hkjl to navigate windows
map {'n', '<C-h>', '<C-w>h'}
map {'n', '<C-k>', '<C-w>k'}
map {'n', '<C-j>', '<C-w>j'}
map {'n', '<C-l>', '<C-w>l'}
map {'t', '<C-h>', '<C-\\><C-N><C-w>h'}
map {'t', '<C-k>', '<C-\\><C-N><C-w>k'}
map {'t', '<C-j>', '<C-\\><C-N><C-w>j'}
map {'t', '<C-l>', '<C-\\><C-N><C-w>l'}

-- Stay in visual mode
map {'v', '<', '<gv'}
map {'v', '>', '>gv'}


-- Search results centered please
map {'n', 'n', 'nzz', silent = true}
map {'n', 'N', 'Nzz', silent = true}
map {'n', '*', '*zz', silent = true}
map {'n', '#', '#zz', silent = true}
map {'n', 'g*', 'g*zz', silent = true}

-- Very magic by default
map {'n', '?', '?\\v'}
map {'n', '/', '/\\v'}
map {'n', '%s', '%sm/'}

map {'n', '<leader>te', ':tabnew<CR>', silent = true}
map {'n', '<leader>tn', ':tabnext<CR>', silent = true}
map {'n', '<leader>tp', ':tabprevious<CR>', silent = true}

-- Source existing nvim config
vim.cmd 'source ~/.config/nvim/legacy-init.vim'
