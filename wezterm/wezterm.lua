local wezterm = require("wezterm")
local config = {}

-- colors & appearance
config.color_scheme = "tokyonight"
require("powerline")
config.font = wezterm.font("FantasqueSansM Nerd Font Mono")
config.font_size = 13.0

-- window
config.window_background_opacity = 0.9
if wezterm.target_triple == "aarch64-apple-darwin" then
	config.macos_window_background_blur = 30
end
config.window_decorations = "NONE"
config.tab_bar_at_bottom = true

-- Keybinds
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = require("keybinds")

return config
