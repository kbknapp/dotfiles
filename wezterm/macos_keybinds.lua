local wezterm = require("wezterm")
local act = wezterm.action
local keys = {}

keys = {
	{
		key = "H",
		mods = "CTRL|CMD",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "J",
		action = act.AdjustPaneSize({ "Down", 5 }),
		mods = "CTRL|CMD",
	},
	{ key = "K", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{
		key = "L",
		mods = "CTRL|CMD",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
}

return keys
