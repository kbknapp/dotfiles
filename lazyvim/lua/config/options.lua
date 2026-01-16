-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.colorcolumn = "80,100"
opt.hlsearch = true
opt.incsearch = true
opt.isfname:append("@-@")
opt.scrolloff = 8
opt.shell = "/bin/zsh"
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
