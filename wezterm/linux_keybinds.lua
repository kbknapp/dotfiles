local wezterm = require("wezterm")
local act = wezterm.action
local keys = {}

keys = {
	{
		key = "H",
		mods = "CTRL|ALT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "J",
		mods = "CTRL|ALT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{ key = "K", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{
		key = "L",
		mods = "CTRL|ALT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
}

return keys
