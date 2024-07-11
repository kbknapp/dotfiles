return {
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
}
