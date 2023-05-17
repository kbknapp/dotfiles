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
Plug 'godlygeek/tabular'
Plug 'folke/which-key.nvim'
Plug 'tpope/vim-repeat' -- Repeat all commands with . not just native
Plug 'simeji/winresizer' -- Better window resizing with Ctrl+E"
Plug 'ggandor/leap.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'machakann/vim-highlightedyank' -- keep yanked highlighted
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'windwp/nvim-spectre'         -- Search and Replace
Plug 'cshuaimin/ssr.nvim'          -- Structured Search and Replace
Plug 'mitchellh/tree-sitter-hcl'
Plug 'NoahTheDuke/vim-just'
Plug 'chrisbra/unicode.vim'

-- Colorscheme
Plug('folke/tokyonight.nvim', {['branch'] = 'main'})
Plug 'navarasu/onedark.nvim'

-- Run HTTP requests
Plug('NTBBloodbath/rest.nvim', {['do'] = ':TSInstall http json'})

-- Files / Coding
Plug 'kyazdani42/nvim-web-devicons'  -- for file icons
Plug 'kyazdani42/nvim-tree.lua'      -- better NERDTree
Plug 'moll/vim-bbye'                 -- Better Buffer Close support (don't wipe out splits, etc.)
--Plug 'airblade/vim-rooter'           -- Find project root
Plug 'ahmedkhalf/project.nvim'       -- Find project root and project mgmt
Plug 'simrat39/symbols-outline.nvim' -- Tagbar replacement
Plug 'mfussenegger/nvim-dap'
Plug 'github/copilot.vim'            -- Github Copilot; run :Copilot setup

-- Languages
-- Python
Plug('neoclide/coc.nvim', {['branch'] = 'release', ['for'] = 'python' })
Plug('mfussenegger/nvim-dap-python', {['for'] = 'python'})

-- Zig
Plug('ziglang/zig.vim', {['for'] = 'zig'})
Plug('zigtools/zls', {['for'] = 'zig'})

-- Rust
Plug 'saecki/crates.nvim'
--Plug('rust-lang/rust.vim', {['for'] = 'rust'})
Plug('simrat39/rust-tools.nvim', {['for'] = 'rust'})
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
--Plug 'ianding1/leetcode.vim'

-- Git
Plug 'airblade/vim-gitgutter' -- +,-,~ in gutter
Plug 'f-person/git-blame.nvim' -- Blame
Plug 'TimUntersberger/neogit'
Plug 'sindrets/diffview.nvim'

-- TOML
Plug('cespare/vim-toml', {['for'] = 'toml'})

-- Go
Plug('fatih/vim-go', {['for'] = 'go'})

vim.call('plug#end')

---
-- PLUGIN CONFIGURATION
---

-- which-key
--require("which-key").setup()
local wk = require("which-key")

-- Noegit
local neogit = require('neogit')

neogit.setup {
  use_magit_keybindings = true,
  integrations = {
    diffview = true
  }
}

wk.register({
  ["<leader>g"] = { name = "+git" },
  ["<leader>gg"] = {'<cmd>lua require"neogit".open()<CR>', "neogit"},
})

-- leap
require('leap').add_default_mappings()
map {'n', 's', '<cmd>lua require"leap".leap { }<CR>'}
map {'n', 'S', '<cmd>lua require"leap".leap { backwards = true }<CR>'}

-- rest.nvim
require("rest-nvim").setup({
      -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Keep the http file buffer above|left when split horizontal|vertical
      result_split_in_place = true,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = true,
      -- Encode URL before making request
      encode_url = true,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        show_http_info = true,
        show_headers = true,
        -- executables or functions for formatting response body [optional]
        -- set them to nil if you want to disable them
        formatters = {
          json = "jq",
          html = function(body)
            return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
          end
        },
      },
      -- Jump to request line on run
      jump_to_request = false,
      env_file = '.env',
      custom_dynamic_variables = {},
      yank_dry_run = true,
    })

wk.register({
  ["<leader>h"] = {
    name = "+http",
    r = { "<Plug>RestNvim<CR>", "REST Nvim" },
  },
})

-- python-dap
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='🟢', texthl='', numhl=''})
wk.register({
  ["<leader>d"] = { name = "+debug" },
    ["<leader>dp"] = { name = "+python-test" },
      ["<leader>dpm"] = {":lua require'dap-python'.test_method()<CR>", "Test Method" },
      ["<leader>dpc"] = {":lua require'dap-python'.test_class()<CR>", "Test Class" },
      ["<leader>dps"] = {":lua require'dap-python'.debug_selection()<CR>", "Test Selection" },
    ["<leader>dd"] = { ':lua require"dap".run_last()<CR>', "Run Last" },
    ["<leader>dr"] = { ':lua require"dap".repl.open({}, "vsplit")<CR><C-w>la', "REPL"},
    ["<leader>db"] = { ':lua require"dap".toggle_breakpoint()<CR>', "Toggle Breakpoint"},
    ["<leader>dc"] = {':lua require"dap".continue()<CR>', "Continue"},
    ["<leader>ds"] = { name = "+step" },
    ["<leader>dsi"] = {':lua require"dap".step_into()<CR>', "Step In"},
    ["<leader>dso"] = {':lua require"dap".step_over()<CR>', "Step Over"},
    ["<leader>dsO"] = {':lua require"dap".step_out()<CR>', "Step Out"},
})
map {'n', '<F9>', ':lua require"dap".continue()<CR>'}
map {'n', '<F10>', ':lua require"dap".step_into()<CR>'}
map {'n', '<F11>', ':lua require"dap".step_over()<CR>'}
map {'n', '<F12>', ':lua require"dap".step_out()<CR>'}

-- Crates.io
-- vim.cmd [[
--  autocmd BufRead Cargo.toml call crates#toggle()
-- ]]
require('crates').setup()

local crates = require('crates')

wk.register({
  ["<leader>r"] = { name = "+rust" },
    ["<leader>rc"] = { name = "+crates" },
      ["<leader>rct"] = {':lua require("crates").toggle()<cr>', "Toggle"},
      ["<leader>rcr"] = {':lua require("crates").reload()<cr>', "Reload"},
      ["<leader>rcv"] = {':lua require("crates").show_versions_popup()<cr>', "Version Popup"},
      ["<leader>rcf"] = {':lua require("crates").show_features_popup()<cr>', "Features Popup"},
      ["<leader>rcd"] = {':lua require("crates").show_dependencies_popup()<cr>', "Deps Popup"},
      ["<leader>rcu"] = {':lua require("crates").update_crate()<cr>', "Update Crate"},
      ["<leader>rca"] = {':lua require("crates").update_all_crates()<cr>', "Update All Crates"},
      ["<leader>rcU"] = {':lua require("crates").upgrade_crate()<cr>', "Upgrade Crate"},
      ["<leader>rcA"] = {':lua require("crates").upgrade_all_crates()<cr>', "Upgrade All Crates"},
      ["<leader>rcH"] = {':lua require("crates").open_homepage()<cr>', "Homepage"},
      ["<leader>rcR"] = {':lua require("crates").open_repository()<cr>', "Repository"},
      ["<leader>rcD"] = {':lua require("crates").open_documentation()<cr>', "Docs"},
      ["<leader>rcC"] = {':lua require("crates").open_crates_io()<cr>', "Crates.io"},
})

-- Gundo
--map {'n', '<C-u>', ':GundoToggle<CR>'}
--vim.opt.undofile = true     -- persist the undo-tree between sessions
--vim.opt.undolevels = 100
--if vim.fn.has('python3') == 1 then
--    vim.g.gundo_prefer_python3 = true
--end

-- Folds
wk.register({
  ["<leader>z"] = { name = "+fold" },
  ["<leader>zz"] = {':set foldmethod=syntax<cr>', "Fold Syntax"},
  ["<leader>zf"] = {':Folds<cr>', "Folds Plug"},
})

-- Kommentary
require('kommentary.config').configure_language("rust", {
    prefer_single_line_comments = true,
})
map {'n', '<C-/>', 'gcc'}

-- Leetcode
--vim.g.leetcode_browser = 'firefox'
--vim.g.leetcode_solution_filetype = 'rust'
--vim.g.leetcode_hide_paid_only = 1

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
wk.register({
  ["<leader>a"] = { name = "+tabs" },
    ["<leader>a="] = {':Tab /=<CR>', "Align on ="},
    ["<leader>a="] = {':Tab /=<CR>', "Align on =", mode = "v"},
    ['<leader>a"'] = {':Tab /"<CR>', 'Align on "'},
    ['<leader>a"'] = {':Tab /"<CR>', 'Align on "', mode = "v"},
    ["<leader>a'"] = {":Tab /'<CR>", "Align on '"},
    ["<leader>a'"] = {":Tab /'<CR>", "Align on '", mode = "v"},
    ["<leader>a:"] = {":Tab /:\\zs<CR>", "Align on :"},
    ["<leader>a:"] = {":Tab /:\\zs<CR>", "Align on :", mode = "v"},
})

-- Trouble
require("trouble").setup { }
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
wk.register({
  ["<leader>e"] = { name = "+errors" },
    ["<leader>ee"] = {':TroubleToggle<CR>', "Trouble Toggle"},
    ["<leader>ed"] = {':TroubleToggle document_diagnostics<CR>', "Document Diagnostics"},
    ["<leader>ew"] = {':TroubleToggle workspace_diagnostics<CR>', "Workspace Diagnostics"},
    ["<leader>eq"] = {':TroubleToggle quickfix<CR>', "Quickfix"},
    ["<leader>el"] = {':TroubleToggle loclist<CR>', "Loclist"},
    ["<leader>eL"] = {':TroubleToggle lsp_references<CR>', "LSP Refs"},
})

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
    file_ignore_patterns = { "target" },
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

-- Project.nvim
require("project_nvim").setup {
  detection_methods = { "pattern" },
  patterns = { "justfile", "Makefile", "Cargo.toml", "=target", "Cargo.lock", "package.json", ".git" },
}

require('telescope').load_extension('projects')
 -- .load_extension('luasnip')

wk.register({
  ["<leader>pp"] = {'<cmd>lua require"telescope".extensions.projects.projects{}<CR>', "Find Project"}
})

map {'n', '<C-p>', '<cmd>lua require"telescope.builtin".find_files{}<CR>'}
wk.register({
  ["<leader>/"] = {'<cmd>lua require"telescope.builtin".live_grep{}<CR>', "Live Grep"},
  ["<leader>cd"] = {'<cmd>lua require"telescope.builtin".lsp_definitions{}<CR>', "Definitions"},
  ["<leader>gd"] = {'<cmd>lua require"telescope.builtin".lsp_definitions{}<CR>', "Definitions"},
  ["<leader>b"] = {name = "+buffer"},
    ["<leader>bb"] = {'<cmd>lua require"telescope.builtin".buffers{}<CR>', "Buffers"},
  ["<leader>f"] = { name = "+find" },
    ["<leader>fts"] = {'<cmd>lua require"telescope.builtin".treesitter{}<CR>', "Treesitter"},
    ["<leader>ff"] = {'<cmd>lua require"telescope.builtin".find_files{}<CR>', "Files"},
    ["<leader>fg"] = {'<cmd>lua require"telescope.builtin".live_grep{}<CR>', "Live Grep"},
    ["<leader>fb"] = {'<cmd>lua require"telescope.builtin".buffers{}<CR>', "Buffers"},
    ["<leader>ft"] = {'<cmd>lua require"telescope.builtin".tags{}<CR>', "Tags"},
    ["<leader>fm"] = {'<cmd>lua require"telescope.builtin".marks{}<CR>', "Marks"},
    ["<leader>fr"] = {'<cmd>lua require"telescope.builtin".registers{}<CR>', "Registers"},
    ["<leader>fq"] = {'<cmd>lua require"telescope.builtin".quickfix{}<CR>', "Quickfix"},
    ["<leader>fj"] = {'<cmd>lua require"telescope.builtin".jumplist{}<CR>', "Jumplist"},
    ["<leader>fL"] = {'<cmd>lua require"telescope.builtin".loclist{}<CR>', "Loclist"},
    ["<leader>fl"] = {name = "+lsp"},
      ["<leader>flr"] = {'<cmd>lua require"telescope.builtin".lsp_references{}<CR>', "References"},
      ["<leader>flc"] = {name = "+calls"},
        ["<leader>flci"] = {'<cmd>lua require"telescope.builtin".lsp_incoming_calls{}<CR>', "Incoming"},
        ["<leader>flco"] = {'<cmd>lua require"telescope.builtin".lsp_outgoing_calls{}<CR>', "Outgoing"},
      ["<leader>fls"] = {name = "+symbols"},
        ["<leader>flsb"] = {'<cmd>lua require"telescope.builtin".lsp_document_symbols{}<CR>', "Document"},
        ["<leader>flsw"] = {'<cmd>lua require"telescope.builtin".lsp_workspace_symbols{}<CR>', "Workspace"},
        ["<leader>flsW"] = {'<cmd>lua require"telescope.builtin".lsp_dynamic_workspace_symbols{}<CR>', "Workspace Dynamic"},
      ["<leader>fle"] = {'<cmd>lua require"telescope.builtin".diagnostics{}<CR>', "Diagnostics"},
      ["<leader>fli"] = {'<cmd>lua require"telescope.builtin".lsp_implementations{}<CR>', "Implementations"},
      ["<leader>fld"] = {'<cmd>lua require"telescope.builtin".lsp_definitions{}<CR>', "Definitions"},
      ["<leader>fltd"] = {'<cmd>lua require"telescope.builtin".lsp_type_definitions{}<CR>', "Type Definitions"},
    ["<leader>fg"] = {name = "+git"},
      ["<leader>fgl"] = {'<cmd>lua require"telescope.builtin".git_commits{}<CR>', "Log"},
      ["<leader>fgL"] = {'<cmd>lua require"telescope.builtin".git_bcommits{}<CR>', "Log (buffer)"},
      ["<leader>fgb"] = {'<cmd>lua require"telescope.builtin".git_branches{}<CR>', "Branches"},
      ["<leader>fgs"] = {'<cmd>lua require"telescope.builtin".git_status{}<CR>', "Status"},
      ["<leader>fgz"] = {'<cmd>lua require"telescope.builtin".git_stash{}<CR>', "Stash"},
})

-- Spectre
wk.register({
  ["<leader>s"] = {name = "+search"},
    ["<leader>ss"] = {'<cmd>lua require"telescope.builtin".live_grep{}<CR>', "Live Grep"},
    ["<leader>sr"] = {'<cmd>lua require("spectre").open()<CR>', "Spectre"},
    ["<leader>sw"] = {"<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Spectre (Word)"},
    ["<leader>sb"] = {"<cmd>lua require('spectre').open_file_search()<cr>", "Spectre (Buffer)"},
})

--map {'v', '<leader>r', "<cmd>lua require('spectre').open_visual()<CR>"}

-- SSR
wk.register({
  ["<leader>S"] = { function() require("ssr").open() end, "AST Search", mode = "n"},
  ["<leader>S"] = { function() require("ssr").open() end, "AST Search", mode = "x"},
})

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
wk.register({
  ["<leader>n"] = { name = "+NVIMTree"},
    ["<leader>nr"] = {':NvimTreeRefresh<CR>', "Refresh"},
    ["<leader>nf"] = {':NvimTreeFindFile<CR>', "Find Files"},
})

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
  update_focused_file = {
    enable = true,
    update_cwd = true,
    update_root = true,
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
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
})

-- nvim_lsp Setup

--local nvim_lsp = require'lspconfig'
require'lspconfig'.rust_analyzer.setup{}

require('rust-tools').setup({
    tools = { -- rust-tools options
        inlay_hints = {
          auto = false,
	  only_current_line = true,
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
    dap = {
      adapter = {
        type = "executable",
        command = "rust-lldb",
        name = "rt_lldb",
      }
    }
})

wk.register({
  ["<leader>re"] = {':RustExpandMacro<cr>', "Expand Macro"},
  ["<leader>rr"] = {':RustRunnables<cr>', "Runnables"},
  ["<leader>rh"] = {':RustToggleInlayHints<cr>', "Inlay Hints"},
  ["<leader>ra"] = {':RustHoverActions<cr>', "Hover Action"},
  ["<leader>rc"] = {':RustOpenCargo<cr>', "Open Cargo"},
  ["<leader>rm"] = {name = "+move"},
  ["<leader>rmu"] = {':RustMoveItemUp<cr>', "Up"},
  ["<leader>rmd"] = {':RustMoveItemDown<cr>', "Down"},
})

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
    --['<S-Tab>'] = cmp.mapping.select_prev_item(),
    --['<Tab>'] = cmp.mapping.select_next_item(),
    --[[ ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }) ]]
  },

  -- Sources
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'crates' },
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
wk.register({
  ["<leader>bp"] = {':bp<CR>', "Previous", noremap = false},
  ["<leader>bn"] = {':bn<CR>', "Next", noremap = false},
  ["<leader>bw"] = {':Bwipeout!<CR>', "Wipeout", noremap = false},
  ["<leader>bk"] = {':Bdelete!<CR>', "Delete", noremap = false},
  ["<leader>bW"] = {':bufdo :Bwipeout!<CR>', "Wipeout All", noremap = false},
  ["<leader>bK"] = {':bufdo :Bdelete!<CR><C-o>', "Kill All", noremap = false},
})

-- Quick-save
wk.register({
  ["<leader>w"] = {':w<CR>', "Save", noremap = false},
})

-- Code navigation shortcuts as found in :help lsp 
-- (<silent>?)
map {'n', "<c-]>", '<cmd>lua vim.lsp.buf.definition()<CR>'}
map {'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>'}
map {'n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>'}
map {'n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>'}
map {'n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>'}
map {'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>'}
map {'n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>'}
map {'n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>'}
-- rust-analyzer does not yet support goto declaration
-- re-mapped `gd` to definition
map {'n', 'gd', '<cmd>lua require"telescope.builtin".lsp_definitions{}<CR>'}
-- Goto previous/next diagnostic warning/error
map {'n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>'}
map {'n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>'}

-- Rust Language Support

-- Always run rustfmt is applicable and always use stable.
vim.g.rustfmt_autosave_if_config_present = 1
vim.g.rustfmt_command = "rustfmt +stable"

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

map {'n', '<C-s>', ':SymbolsOutline<CR>'}
wk.register({
  ["<leader>oo"] = {':SymbolsOutline<CR>', "Symbol Outline"},
})
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
wk.register({
  ["<leader>h"] = {name = "+highlight"},
  ["<leader>hl"] = {':set cursorline! cursorcolumn!<CR>', "Cross"},
})

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
wk.register({
  ["<leader>,"] = {':set invlist<cr>', "Hidden Chars"},
})

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
wk.register({
  ["<leader>o"] = {name = "+open"},
  ["<leader>ot"] = {':terminal<CR>', "Terminal"},
})

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

wk.register({
  ["<leader>t"] = { name = "+tab" },
  ["<leader>te"] = {':tabnew<CR>', "New"},
  ["<leader>tn"] = {':tabnext<CR>', "Next"},
  ["<leader>tp"] = {':tabprevious<CR>', "Previous"},
})

-- Source existing nvim config
vim.cmd 'source ~/.config/nvim/legacy-init.vim'

-- --
-- Autocommands
-- --

-- Format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
-- Rust-tags support
vim.cmd [[autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi]]
vim.cmd [[autocmd BufWritePost *.rs :silent! exec '!rusty-tags vi --quiet --start-dir=' . expand('%:p:h') . '&' | redraw!]]

-- Prevent accidental writes to buffers that shouldn't be edited
vim.cmd [[autocmd BufRead *.orig set readonly]]
vim.cmd [[autocmd BufRead *.pacnew set readonly]]

-- Leave paste mode when leaving insert mode
vim.cmd [[autocmd InsertLeave * set nopaste]]

-- Auto-make less files on save
vim.cmd [[autocmd BufWritePost *.less if filereadable("Makefile") | make | endif]]

-- Help filetype detection
vim.cmd [[autocmd BufRead *.plot set filetype=gnuplot]]
vim.cmd [[autocmd BufRead *.md set filetype=markdown]]
vim.cmd [[autocmd BufRead *.lds set filetype=ld]]
vim.cmd [[autocmd BufRead *.tex set filetype=tex]]
vim.cmd [[autocmd BufRead *.trm set filetype=c]]
vim.cmd [[autocmd BufRead *.xlsx.axlsx set filetype=ruby]]

-- Flag bad whitespace
vim.cmd [[au BufRead,BufNewFile *.rs,*.py,*.pyw,*.c,*.h,*.md match BadWhitespace /\s\+$/]]
vim.cmd [[au BufNewFile,BufRead *.rs setlocal colorcolumn=100]]
vim.cmd [[au BufNewFile,BufRead *.py setlocal colorcolumn=80]]
vim.cmd [[au BufNewFile,BufReadPost *.py setlocal foldmethod=indent]]
vim.cmd [[au BufNewFile,BufReadPost *.rs setlocal foldmethod=syntax]]

-- Script plugins
vim.cmd [[autocmd Filetype html,xml,xsl,php source ~/.config/nvim/scripts/closetag.vim]]

-- Jump to last edit position on opening file
-- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
vim.cmd [[au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]


-- Markdown Help
vim.cmd [[autocmd FileType markdown set cursorline]]
vim.cmd [[autocmd FileType markdown set conceallevel=2]]
vim.cmd [[autocmd FileType markdown set linebreak]]
vim.cmd [[autocmd FileType markdown setlocal scrolloff=12]]
vim.cmd [[autocmd FileType markdown setlocal spell spelllang=en_us]]

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true
  },
  auto_install = true
}

