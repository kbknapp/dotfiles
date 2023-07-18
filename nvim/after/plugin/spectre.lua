local tsb = require"telescope.builtin"
local spectre = require("spectre")

vim.keymap.set("n", "<leader>s", "<nop>", {desc = "+search"})
vim.keymap.set("n", "<leader>ss", function() tsb.live_grep{} end, {desc ="Live Grep"})
vim.keymap.set("n", "<leader>sr", function() spectre.open() end, {desc ="Spectre"})
vim.keymap.set("n", "<leader>sw", function() spectre.open_visual({select_word=true}) end, {desc ="Spectre (Word)"})
vim.keymap.set("n", "<leader>sb", function() spectre.open_file_search() end, {desc = "Spectre (Buffer)"})

-- Muscle Memory
vim.keymap.set("n", "<leader>fc", function() spectre.open_visual({select_word=true}) end, {desc ="Spectre (Word)"})
