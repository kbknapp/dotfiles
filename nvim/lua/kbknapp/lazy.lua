local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- set `mapleader` before lazy so mappings are correct
vim.g.mapleader = " "

require("lazy").setup({
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({
        icons = false,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      'neovim/nvim-lspconfig',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
    },
  },

  --{
  --  'huggingface/llm.nvim',
  --  opts = {
  --    -- cf Setup
  --    backend = "ollama",
  --    model = "dolphincoder:15b-starcoder2-q5_K_M",
  --    url = "http://100.111.120.93:11434/api/generate",
  --    -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
  --    request_body = {
  --      -- Modelfile options for the model you use
  --      options = {
  --        temperature = 0.2,
  --        top_p = 0.95,
  --      }
  --    }
  --  }
  --},
   -- Rust
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      {
        "lvimuser/lsp-inlayhints.nvim",
        opts = {}
      },
    },
    ft = { "rust" },
  },

  {
    'NeogitOrg/neogit',
    dependencies = 'nvim-lua/plenary.nvim'
  },

  {
    'mzlogin/vim-markdown-toc',
    ft = {'markdown'},
  },

  {
    'plasticboy/vim-markdown',
    ft = {'markdown'},
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  'christoomey/vim-tmux-navigator',
  "github/copilot.vim",
  "theprimeagen/harpoon", -- Quick jump between files
  "nvim-treesitter/nvim-treesitter-context",
  'bitc/vim-bad-whitespace', -- show bad whitespace
  'kbknapp/badWords', -- Highlight bad words for general audience
  'folke/which-key.nvim', -- Show keybindings
  'simeji/winresizer', -- Better resizing with C-e
  'machakann/vim-highlightedyank', -- Keep yanked text highlighted
  'windwp/nvim-spectre', -- Search and Replace
  'nvim-tree/nvim-tree.lua', -- NERDTree replacement
  'b3nj5m1n/kommentary', -- better commenting with gcc
  'f-person/git-blame.nvim', -- Blame
  'ahmedkhalf/project.nvim', -- Project management
  'navarasu/onedark.nvim',

})
