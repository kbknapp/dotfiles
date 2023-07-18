require("trouble").setup { }
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local wk = require("which-key")
wk.register({
  ["<leader>e"] = { name = "+errors" },
    ["<leader>ee"] = {':TroubleToggle<CR>', "Trouble Toggle"},
    ["<leader>ed"] = {':TroubleToggle document_diagnostics<CR>', "Document Diagnostics"},
    ["<leader>ew"] = {':TroubleToggle workspace_diagnostics<CR>', "Workspace Diagnostics"},
    ["<leader>eq"] = {':TroubleToggle quickfix<CR>', "Quickfix"},
    ["<leader>el"] = {':TroubleToggle loclist<CR>', "Loclist"},
    ["<leader>eL"] = {':TroubleToggle lsp_references<CR>', "LSP Refs"},
})

