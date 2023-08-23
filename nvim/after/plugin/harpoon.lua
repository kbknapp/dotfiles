local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>h", "<nop>", {desc ="+harpoon"})
vim.keymap.set("n", "<leader>ha", function() mark.add_file() end, {desc ="Add File"})
vim.keymap.set("n", "<leader>hm", function() ui.toggle_quick_menu() end, {desc ="Quick Menu"})
vim.keymap.set("n", "<leader>hn", function() ui.nav_next() end, {desc ="Next Mark"})
vim.keymap.set("n", "<leader>hp", function() ui.nav_prev() end, {desc ="Prev Mark"})
vim.keymap.set("n", "<leader>h1", function() ui.nav_file(1) end, {desc ="Nav File 1"})
vim.keymap.set("n", "<leader>h2", function() ui.nav_file(2) end, {desc ="Nav File 2"})
vim.keymap.set("n", "<leader>h3", function() ui.nav_file(3) end, {desc ="Nav File 3"})

-- vim.keymap.set("n", "<C-h>", function() ui.toggle_quick_menu() end)
-- vim.keymap.set("n", "<C-j>", function() ui.nav_file(1) end)
-- vim.keymap.set("n", "<C-k>", function() ui.nav_file(2) end)
-- vim.keymap.set("n", "<C-l>", function() ui.nav_file(3) end)
