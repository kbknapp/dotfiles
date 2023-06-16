-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    ["<leader><leader>"] = {'<c-^>'},
    ["<C-n>"] = {'<cmd>Neotree toggle<cr>'},
    ["<leader>e"] = { name = "+errors" },
    ["<leader>ee"] = {':TroubleToggle<CR>', desc = "Trouble Toggle"},
    ["<leader>ed"] = {':TroubleToggle document_diagnostics<CR>', desc ="Document Diagnostics"},
    ["<leader>ew"] = {':TroubleToggle workspace_diagnostics<CR>', desc = "Workspace Diagnostics"},
    ["<leader>eq"] = {':TroubleToggle quickfix<CR>', desc = "Quickfix"},
    ["<leader>el"] = {':TroubleToggle loclist<CR>', desc = "Loclist"},
    ["<leader>eL"] = {':TroubleToggle lsp_references<CR>', desc = "LSP Refs"},
    ["<leader>gg"] = { '<cmd>lua require"neogit".open()<cr>', desc = "neogit"},
    ["<leader>gG"] = { function() utils.toggle_term_cmd "lazygit" end, desc = "ToggleTerm lazygit" },
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bp"] = { "<cmd>bp<cr>", desc = "Preivous Buffer" },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
