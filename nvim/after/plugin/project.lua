require("project_nvim").setup {
  detection_methods = { "pattern" },
  patterns = { "justfile", "Makefile", "Cargo.toml", "=target", "Cargo.lock", "package.json", ".git" },
}

require('telescope').load_extension('projects')
 -- .load_extension('luasnip')

vim.keymap.set("n", "<leader>pp",  function() require"telescope".extensions.projects.projects{} end, {desc = "Find Project"})
