require('kommentary.config').configure_language("rust", {
    prefer_single_line_comments = true,
})
vim.keymap.set('n', '<C-/>', 'gcc', { desc = "Comment line" })
