local module = {}

function module.get_keys(wezterm)
	local act = wezterm.action
	local keys = {}
	keys = {
		{
			key = ",",
			mods = "SUPER",
			action = act.SpawnCommandInNewTab({
				cwd = wezterm.home_dir,
				args = { "nvim", wezterm.config_file },
			}),
		},
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
end

return module
