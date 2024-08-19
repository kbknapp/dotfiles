local wezterm = require("wezterm")
local config = {}

if wezterm.target_triple == "aarch64-apple-darwin" then
	config.set_environment_variables = {
		PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
	}
end

-- colors & appearance
require("powerline")
config.color_scheme = "tokyonight"
config.font = wezterm.font("FantasqueSansM Nerd Font Mono")
if wezterm.target_triple == "aarch64-apple-darwin" then
	config.font_size = 14.0
else
	config.font_size = 13.0
end

-- window
if wezterm.target_triple == "aarch64-apple-darwin" then
	config.macos_window_background_blur = 30
	config.window_decorations = "RESIZE"
	config.window_background_opacity = 0.8
else
	config.window_background_opacity = 0.9
	config.window_decorations = "NONE"
end
config.tab_bar_at_bottom = true

-- Keybinds
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = require("keybinds").get_keys(wezterm)

return config
