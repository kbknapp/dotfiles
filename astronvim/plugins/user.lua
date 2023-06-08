return {
  {"NoahTheDuke/vim-just", event = "BufEnter *.just,justfile"},
  "bitc/vim-bad-whitespace",
  "kbknapp/badWords",
  {'NTBBloodbath/rest.nvim', event = "BufEnter *.http"},
  {
    'TimUntersberger/neogit',
    event = "User AstroGitFile",
    config = function()
      require('neogit').setup {
        use_magit_keybindings = true,
        -- customize displayed signs
        --signs = {
        --  -- { CLOSED, OPENED }
        --  section = { ">", "v" },
        --  item = { ">", "v" },
        --  hunk = { "", "" },
        --},
        integrations = {
          -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs,
          -- you can use `sindrets/diffview.nvim`.
          --
          -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
          --
          -- Requires you to have `sindrets/diffview.nvim` installed.
          diffview = true,
        },
      }
    end,
  },
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
}
