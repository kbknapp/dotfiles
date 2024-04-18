vim.cmd [[autocmd BufWritePre *.rs lua vim.lsp.buf.format()]]

vim.g.rustfmt_command = "cargo +nightly fmt"

vim.g.rustaceanvim = {
  -- LSP configuration
  server = {
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
        check = {
          command = "clippy"
        },
        rustfmt = {
          extraArgs = { "+nightly" },
        },
        checkOnSave = {
            command = "clippy"
        },
      },
    },
  },
}

