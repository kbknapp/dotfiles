local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use('navarasu/onedark.nvim')
  use({
      "folke/tokyonight.nvim",
	  as = 'tokyonight',
  })

  use({
      "folke/trouble.nvim",
      config = function()
          require("trouble").setup {
              icons = false,
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
          }
      end
  })

  use({
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
    end,})

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},

          -- Rust
          {'simrat39/rust-tools.nvim'},

	  }
  }
  use({
      "rest-nvim/rest.nvim",
      requires = { "nvim-lua/plenary.nvim" },
    })

  use("github/copilot.vim")
  use("theprimeagen/harpoon") -- Quick jump between files
  use("mbbill/undotree") -- Deep undo tree
  use({'NeogitOrg/neogit', requires = 'nvim-lua/plenary.nvim'})
  use("nvim-treesitter/nvim-treesitter-context")
  use('bitc/vim-bad-whitespace') -- show bad whitespace
  use('kbknapp/badWords') -- Highlight bad words for general audience
  use('folke/which-key.nvim') -- Show keybindings
  use('simeji/winresizer') -- Better resizing with C-e
  use('machakann/vim-highlightedyank') -- Keep yanked text highlighted
  use('windwp/nvim-spectre' ) -- Search and Replace
  use('kyazdani42/nvim-web-devicons') -- Tree Icons
  use('nvim-tree/nvim-tree.lua') -- NERDTree replacement
  use('b3nj5m1n/kommentary') -- better commenting with gcc
  use({'mzlogin/vim-markdown-toc', ft = {'markdown'}})
  use({'plasticboy/vim-markdown', ft = {'markdown'}})
  --use('airblade/vim-gitgutter') -- +,-,~ in gutter
  use('f-person/git-blame.nvim') -- Blame
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons',
    opt = true }
  }) -- Statusline
  use('ahmedkhalf/project.nvim') -- Project management

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
