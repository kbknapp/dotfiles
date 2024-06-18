local builtin = require('telescope.builtin')
local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--follow',
      '--hidden'
    },
    prompt_prefix = " ",
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
    file_ignore_patterns = { "target", "vendor*" },
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
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
    },
  }
}

local tsb = require'telescope.builtin'
vim.keymap.set("n", "<leader>/", function() tsb.live_grep{} end, {desc ="Grep"})

vim.keymap.set("n", "<leader>b", "<nop>", {desc= "+buffer"})
vim.keymap.set("n", "<leader>bb", function() tsb.buffers{} end, {desc ="Buffers"})

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<C-p>", function() require"telescope.builtin".find_files{} end)

vim.keymap.set("n", "<leader>f", "<nop>", { desc = "+find" })
vim.keymap.set("n", "<leader>fts", function() tsb.treesitter{} end, {desc = "Treesitter"})
vim.keymap.set("n", "<leader>ff", function() tsb.find_files{} end, {desc = "Files"})
vim.keymap.set("n", "<leader>ffg", function() tsb.git_files{} end, {desc = "Git Files"})
vim.keymap.set("n", "<leader>fb", function() tsb.buffers{} end, {desc = "Buffers"})
vim.keymap.set("n", "<leader>ft", function() tsb.tags{} end, {desc = "Tags"})
vim.keymap.set("n", "<leader>fm", function() tsb.marks{} end, {desc = "Marks"})
vim.keymap.set("n", "<leader>fr", function() tsb.registers{} end, {desc = "Registers"})
vim.keymap.set("n", "<leader>fq", function() tsb.quickfix{} end, {desc = "Quickfix"})
vim.keymap.set("n", "<leader>fj", function() tsb.jumplist{} end, {desc = "Jumplist"})
vim.keymap.set("n", "<leader>fL", function() tsb.loclist{} end, {desc = "Loclist"})

vim.keymap.set("n", "<leader>fg", "<nop>", {desc= "+git"})
vim.keymap.set("n", "<leader>fgl", function() tsb.git_commits{} end, {desc = "Log"})
vim.keymap.set("n", "<leader>fgL", function() tsb.git_bcommits{} end, {desc = "Log (buffer)"})
vim.keymap.set("n", "<leader>fgb", function() tsb.git_branches{} end, {desc = "Branches"})
vim.keymap.set("n", "<leader>fgs", function() tsb.git_status{} end, {desc = "Status"})
vim.keymap.set("n", "<leader>fgz", function() tsb.git_stash{} end, {desc = "Stash"})

vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "Help Tags" })

require("telescope").load_extension("harpoon")
vim.keymap.set("n", "<leader>fM", "<cmd>Telescope harpoon marks<cr>", {desc = "Harpoon Marks"})

