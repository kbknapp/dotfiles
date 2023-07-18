vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
vim.g.gitblame_date_format = '%r'

local git_blame = require('gitblame')

require('lualine').setup {
  options = {
    theme = 'tokyonight'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diff', 'diagnostics'},
    lualine_c = {
      { 'filename', path = 1},
      { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
}
