local neogit = require('neogit')

neogit.setup {
  use_magit_keybindings = true,
  integrations = {
    diffview = true
  }
}

vim.keymap.set("n", "<leader>g", "<nop>", { desc = "+git" })
vim.keymap.set("n", "<leader>gg",  function() neogit.open() end, { desc = "neogit"})

