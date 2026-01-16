return {
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    keys = {
      {
        "<leader>ee",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>eE",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>es",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>el",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>eL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>eQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-frappe",
    },
  },
  "kbknapp/badWords", -- Highlight bad words for general audience
  "simeji/winresizer", -- Better resizing with C-e
  "b3nj5m1n/kommentary", -- better commenting with gcc
  {
    "NeogitOrg/neogit",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      use_magit_keybindings = true,
      integrations = {
        diffview = true,
      },
    },
    keys = {
      {
        "<leader>gg",
        function()
          require("neogit").open()
        end,
        { desc = "neogit" },
      },
    },
  },
  {
    "mzlogin/vim-markdown-toc",
    ft = { "markdown" },
  },

  {
    "plasticboy/vim-markdown",
    ft = { "markdown" },
  },
}
