require("trouble").setup { }
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local wk = require("which-key")
vim.keymap.set("n", "<leader>e", "<nop>", { desc = "+errors" })
vim.keymap.set("n", "<leader>ee", '<cmd>TroubleToggle<CR>', {desc ="Trouble Toggle"})
vim.keymap.set("n", "<leader>ed", '<cmd>TroubleToggle document_diagnostics<CR>', {desc = "Document Diagnostics"})
vim.keymap.set("n", "<leader>ew", '<cmd>TroubleToggle workspace_diagnostics<CR>', {desc = "Workspace Diagnostics"})
vim.keymap.set("n", "<leader>eq", '<cmd>TroubleToggle quickfix<CR>', {desc = "Quickfix"})
vim.keymap.set("n", "<leader>el", '<cmd>TroubleToggle loclist<CR>', {desc = "Loclist"})
vim.keymap.set("n", "<leader>eL", '<cmd>TroubleToggle lsp_references<CR>', {desc = "LSP Refs"})


