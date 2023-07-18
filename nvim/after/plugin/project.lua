require("project_nvim").setup {
  detection_methods = { "pattern" },
  patterns = { "justfile", "Makefile", "Cargo.toml", "=target", "Cargo.lock", "package.json", ".git" },
}

require('telescope').load_extension('projects')
 -- .load_extension('luasnip')

local wk = require("which-key")
wk.register({
  ["<leader>pp"] = {'<cmd>lua require"telescope".extensions.projects.projects{}<CR>', "Find Project"}
})
