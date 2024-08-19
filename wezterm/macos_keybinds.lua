local module = {}

function module.get_keys(wezterm)
	local act = wezterm.action
	local keys = {}
	keys = {
		{
			key = ",",
			mods = "CMD",
			action = act.SpawnCommandInNewTab({
				cwd = wezterm.home_dir,
				args = { "nvim", wezterm.config_file },
			}),
		},
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
end

return module
