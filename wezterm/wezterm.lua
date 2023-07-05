local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'FantasqueSansM Nerd Font'
config.color_scheme = 'Tokyo Night Storm (Gogh)'
config.window_background_opacity = 0.9
config.window_decorations = "NONE"
config.hide_tab_bar_if_only_one_tab = true

return config
