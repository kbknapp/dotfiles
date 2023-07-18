vim.cmd [[autocmd BufWritePre *.rs lua vim.lsp.buf.format()]]

vim.g.rustfmt_command = "cargo +nightly fmt"

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
        -- custom config here
    end,
  },
})

require('lspconfig').rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy"
            },
        }
    },
    on_attach = function(client, bufnr)
      require'completion'.on_attach(client)
    end
})


