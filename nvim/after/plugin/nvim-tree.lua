vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = "Toggle NvimTree" })
vim.keymap.set("n", "<leader>n", "<nop>", { desc = "+NVIMTree"})
vim.keymap.set("n", "<leader>nr", '<cmd>NvimTreeRefresh<CR>', {desc ="Refresh"})
vim.keymap.set("n", "<leader>nf", '<cmd>NvimTreeFindFile<CR>', {desc = "Find Files"})

require'nvim-tree'.setup({
  -- will show lsp diagnostics in the signcolumn.
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    update_root = true,
  },
  -- when moving cursor in the tree, position the cursor at the start of the file on the current line
  hijack_cursor = false,
  renderer = {
    -- will enable folder and file icon highlight for opened files/directories.
    highlight_opened_files = "name",
    -- compact folders that only contain a single folder into one node in the file tree
    group_empty = true,
    -- will enable file highlight for git attributes (can be used without the icons).
    highlight_git = true,
    -- append a trailing slash to folder names
    add_trailing = true,
    indent_markers = {
	enable = true,
    }
  },
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
})

