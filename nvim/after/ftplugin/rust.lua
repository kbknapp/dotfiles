local bufnr = vim.api.nvim_get_current_buf()
local opts = { silent = true, buffer = bufnr }
vim.keymap.set(
{"n", "v"},
  "<leader>a",
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  opts
)

vim.keymap.set(
  "n",
  "<leader>em",
  function()
    vim.cmd.RustLsp('expandMacro')
  end,
  opts
)

vim.keymap.set(
{"n", "v"},
  "<leader>aa",
  function()
    vim.cmd.RustLsp{ 'hover', 'actions' }
  end,
  opts
)

vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
--vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
--vim.keymap.set('n', '<leader>wl', function()
--  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--end, opts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
--vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
