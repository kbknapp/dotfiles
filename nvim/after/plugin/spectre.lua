local wk = require("which-key")
wk.register({
  ["<leader>s"] = {name = "+search"},
    ["<leader>ss"] = {'<cmd>lua require"telescope.builtin".live_grep{}<CR>', "Live Grep"},
    ["<leader>/"] = {'<cmd>lua require"telescope.builtin".live_grep{}<CR>', "Live Grep"},
    ["<leader>sr"] = {'<cmd>lua require("spectre").open()<CR>', "Spectre"},
    ["<leader>sw"] = {"<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Spectre (Word)"},
    ["<leader>sb"] = {"<cmd>lua require('spectre').open_file_search()<cr>", "Spectre (Buffer)"},
})
