local neogit = require('neogit')
local wk = require("which-key")

wk.register({
  ["<leader>g"] = { name = "+git" },
  ["<leader>gg"] = {'<cmd>lua require"neogit".open()<CR>', "neogit"},
})

neogit.setup {
  use_magit_keybindings = true,
  integrations = {
    diffview = true
  }
}

