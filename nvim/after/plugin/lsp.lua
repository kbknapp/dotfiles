local lsp = require("lsp-zero")

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.preset("recommended")

lsp.ensure_installed({
  'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
})

--require('mason').setup()
--require('mason-lspconfig').setup()

require('lspconfig').rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = {
        command = "clippy"
      },
      rustfmt = {
        extraArgs = { "+nightly" },
      },
    }
  }
})

vim.diagnostic.config({
    virtual_text = true
})

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end)

local tsb = require('telescope.builtin')

  -- Muscle memory from emacs...
vim.keymap.set("n", "<leader>cd", function() tsb.lsp_definitions{} end, { desc = "defs"})
vim.keymap.set("n", "<leader>gd",  function() tsb.lsp_definitions{} end , { desc = "defs"})
vim.keymap.set("n", "<leader>l", "<nop>", { desc = "+lsp" })
vim.keymap.set("n", "<leader>lf",  function() vim.lsp.buf.format { async = true } end, { desc = "format"})
vim.keymap.set("n", "<leader>lk",  function() vim.lsp.buf.hover() end, { desc = "hover"})
vim.keymap.set("n", "<leader>lca",  function() vim.lsp.buf.code_action() end, { desc = "code actions"})
vim.keymap.set("n", "<leader>lr",  function() vim.lsp.buf.references() end, { desc = "refs"})
vim.keymap.set("n", "<leader>lmv",  function() vim.lsp.buf.rename() end, { desc = "rename"})
vim.keymap.set("n", "<leader>ls", "<nop>", {desc = "+symbols"})
vim.keymap.set("n", "<leader>lsb",  function() tsb.lsp_document_symbols{} end, {desc = "document"})
vim.keymap.set("n", "<leader>lsw",  function() tsb.lsp_workspace_symbols{} end, {desc = "workspace"})
vim.keymap.set("n", "<leader>lsW",  function() tsb.lsp_dynamic_workspace_symbols{} end, {desc = "dyn workspace"})
vim.keymap.set("n", "<leader>fle",  function() tsb.diagnostics{} end,{desc =  "Diagnostics"})
vim.keymap.set("n", "<leader>fli", function() tsb.lsp_implementations{} end , {desc = "Implementations"})
vim.keymap.set("n", "<leader>fld", function() tsb.lsp_definitions{} end, {desc = "Definitions"})
vim.keymap.set("n", "<leader>fltd", function() tsb.lsp_type_definitions{} end, {desc = "Type Definitions"})
