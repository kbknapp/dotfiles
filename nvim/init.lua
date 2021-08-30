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

-- Files
Plug 'kyazdani42/nvim-web-devicons' -- for file icons
Plug 'kyazdani42/nvim-tree.lua'     -- better NERDTree
-- Better Buffer Close support (don't wipe out splits, etc.)
Plug 'moll/vim-bbye'

Plug 'airblade/vim-rooter' -- Find project root

-- Languages

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'windwp/nvim-spectre'

-- Zig
Plug 'ziglang/zig.vim'

-- Rust
Plug 'mhinz/vim-crates'
Plug 'rust-lang/rust.vim'
--Plug 'racer-rust/vim-racer'

-- nvim-lsp based
Plug 'neovim/nvim-lspconfig'           -- Common configuration
Plug 'nvim-lua/lsp_extensions.nvim'    -- type inlay hints, etc
Plug 'hrsh7th/nvim-cmp'                -- Autocompletion
Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/vim-vsnip'               -- Snippet handling
Plug 'simrat39/rust-tools.nvim'        -- Rust
Plug 'zigtools/zls'                    -- Zig
Plug 'hrsh7th/cmp-buffer'
Plug 'ray-x/lsp_signature.nvim'        -- Function signatures

-- Semantic language support
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

-- Comment or UN-Comment Code
--    -> gcc                  Comment or uncomment line(s)
Plug 'b3nj5m1n/kommentary'

-- Better surround support
--     -> cs"'     "Hello"->'Hello'
--     -> ysiw[   'Hello'->[Hello]
--     -> ds[     [Hello]->Hello
Plug 'tpope/vim-surround'

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
map {'n', '<leader>ff', '<cmd>Telescope find_files<CR>'}
map {'n', '<C-p>', '<cmd>Telescope find_files<CR>'}
map {'n', '<leader>/', '<cmd>Telescope live_grep<CR>'}
map {'n', '<leader>fg', '<cmd>Telescope live_grep<CR>'}
map {'n', '<leader>ss', '<cmd>Telescope live_grep<CR>'}
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
        }
end

require "lsp_signature".setup()

vim.g.completion_enable_auto_popup = true -- Enable completions as you type
vim.g.localvimrc = false -- Don't confirm .lvimrc

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


-- nvim-cmp Configuration

local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = '...' },
      ...
    },
    formatting = {
      format = function(entry, vim_item)
        -- fancy icons and a name of kind
        vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
    
        -- set a name for each source
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[Latex]",
        })[entry.source.name]
        return vim_item
      end,
    }
})


-- Rust Language Support
local opts = {
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
}

require('rust-tools').setup(opts)

vim.cmd[[colorscheme tokyonight]]
vim.g.tokyonight_style = "night"

-- LuaLine
require('lualine').setup {
  options = {
    theme = 'tokyonight'
  }
}

-- Source existing nvim config
vim.cmd 'source ~/.config/nvim/legacy-init.vim'

