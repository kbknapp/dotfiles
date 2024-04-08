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

      -- Rust
      {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = { 'rust' },
      }

    },
  },

  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
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
