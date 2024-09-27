local module = {}

function module.get_keys(wezterm)
	local act = wezterm.action
	local keys = {}
	keys = {
		{
			key = "L",
			mods = "LEADER",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "J",
			mods = "LEADER",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "D",
			mods = "CTRL",
			action = act.ShowDebugOverlay,
		},
		{ key = "p", mods = "LEADER", action = act.MoveTabRelative(-1) },
		{ key = "n", mods = "LEADER", action = act.MoveTabRelative(1) },
		{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
		{
			key = "h",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Down"),
		},
		{
			key = "c",
			mods = "LEADER",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "F",
			mods = "CMD",
			action = act.ToggleFullScreen,
		},
		{
			key = "r",
			mods = "LEADER",
			action = act.RotatePanes("CounterClockwise"),
		},
		{ key = "R", mods = "LEADER", action = act.RotatePanes("Clockwise") },
		{ key = "M", mods = "CTRL", action = act.Nop },
	}

	if wezterm.target_triple == "aarch64-apple-darwin" then
		for _, v in ipairs(require("macos_keybinds").get_keys(wezterm)) do
			table.insert(keys, v)
		end
	else
		for _, v in ipairs(require("linux_keybinds").get_keys(wezterm)) do
			table.insert(keys, v)
		end
	end

	return keys
end

return module
