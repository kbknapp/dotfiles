local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
vim.keymap.set("n", "<C-p>", function() require"telescope.builtin".find_files{} end)

local trouble = require("trouble.providers.telescope")
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = { "target" },
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    }
  }
}
local wk = require("which-key")
wk.register({
  ["<leader>/"] = {'<cmd>lua require"telescope.builtin".live_grep{}<CR>', "Live Grep"},
  ["<leader>cd"] = {'<cmd>lua require"telescope.builtin".lsp_definitions{}<CR>', "Definitions"},
  ["<leader>gd"] = {'<cmd>lua require"telescope.builtin".lsp_definitions{}<CR>', "Definitions"},
  ["<leader>b"] = {name = "+buffer"},
    ["<leader>bb"] = {'<cmd>lua require"telescope.builtin".buffers{}<CR>', "Buffers"},
  ["<leader>f"] = { name = "+find" },
    ["<leader>fts"] = {'<cmd>lua require"telescope.builtin".treesitter{}<CR>', "Treesitter"},
    ["<leader>ff"] = {'<cmd>lua require"telescope.builtin".find_files{}<CR>', "Files"},
    ["<leader>ffg"] = {'<cmd>lua require"telescope.builtin".git_files{}<CR>', "Files"},
    ["<leader>fg"] = {'<cmd>lua require"telescope.builtin".live_grep{}<CR>', "Live Grep"},
    ["<leader>fb"] = {'<cmd>lua require"telescope.builtin".buffers{}<CR>', "Buffers"},
    ["<leader>ft"] = {'<cmd>lua require"telescope.builtin".tags{}<CR>', "Tags"},
    ["<leader>fm"] = {'<cmd>lua require"telescope.builtin".marks{}<CR>', "Marks"},
    ["<leader>fr"] = {'<cmd>lua require"telescope.builtin".registers{}<CR>', "Registers"},
    ["<leader>fq"] = {'<cmd>lua require"telescope.builtin".quickfix{}<CR>', "Quickfix"},
    ["<leader>fj"] = {'<cmd>lua require"telescope.builtin".jumplist{}<CR>', "Jumplist"},
    ["<leader>fL"] = {'<cmd>lua require"telescope.builtin".loclist{}<CR>', "Loclist"},
    ["<leader>fl"] = {name = "+lsp"},
      ["<leader>flr"] = {'<cmd>lua require"telescope.builtin".lsp_references{}<CR>', "References"},
      ["<leader>flc"] = {name = "+calls"},
        ["<leader>flci"] = {'<cmd>lua require"telescope.builtin".lsp_incoming_calls{}<CR>', "Incoming"},
        ["<leader>flco"] = {'<cmd>lua require"telescope.builtin".lsp_outgoing_calls{}<CR>', "Outgoing"},
      ["<leader>fls"] = {name = "+symbols"},
        ["<leader>flsb"] = {'<cmd>lua require"telescope.builtin".lsp_document_symbols{}<CR>', "Document"},
        ["<leader>flsw"] = {'<cmd>lua require"telescope.builtin".lsp_workspace_symbols{}<CR>', "Workspace"},
        ["<leader>flsW"] = {'<cmd>lua require"telescope.builtin".lsp_dynamic_workspace_symbols{}<CR>', "Workspace Dynamic"},
      ["<leader>fle"] = {'<cmd>lua require"telescope.builtin".diagnostics{}<CR>', "Diagnostics"},
      ["<leader>fli"] = {'<cmd>lua require"telescope.builtin".lsp_implementations{}<CR>', "Implementations"},
      ["<leader>fld"] = {'<cmd>lua require"telescope.builtin".lsp_definitions{}<CR>', "Definitions"},
      ["<leader>fltd"] = {'<cmd>lua require"telescope.builtin".lsp_type_definitions{}<CR>', "Type Definitions"},
    ["<leader>fg"] = {name = "+git"},
      ["<leader>fgl"] = {'<cmd>lua require"telescope.builtin".git_commits{}<CR>', "Log"},
      ["<leader>fgL"] = {'<cmd>lua require"telescope.builtin".git_bcommits{}<CR>', "Log (buffer)"},
      ["<leader>fgb"] = {'<cmd>lua require"telescope.builtin".git_branches{}<CR>', "Branches"},
      ["<leader>fgs"] = {'<cmd>lua require"telescope.builtin".git_status{}<CR>', "Status"},
      ["<leader>fgz"] = {'<cmd>lua require"telescope.builtin".git_stash{}<CR>', "Stash"},
})
