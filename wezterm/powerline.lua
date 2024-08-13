local wezterm = require("wezterm")

-- Due to luajit not having `utf8.char` and wezterm not supporting loading C
-- modules such as `luautf8` via luarocks we resort to:
-- https://stackoverflow.com/questions/7983574/how-to-write-a-unicode-symbol-in-lua
--
-- See also:
-- https://github.com/wez/wezterm/issues/2088
-- https://github.com/starwing/luautf8
do
	local bytemarkers = { { 0x7FF, 192 }, { 0xFFFF, 224 }, { 0x1FFFFF, 240 } }
	function utf8(decimal)
		if decimal < 128 then
			return string.char(decimal)
		end
		local charbytes = {}
		for bytes, vals in ipairs(bytemarkers) do
			if decimal <= vals[1] then
				for b = bytes + 1, 2, -1 do
					local mod = decimal % 64
					decimal = (decimal - mod) / 64
					charbytes[b] = string.char(128 + mod)
				end
				charbytes[1] = string.char(vals[2] + decimal)
				break
			end
		end
		return table.concat(charbytes)
	end
end

local function segments_for_right_status(window)
	return {
		window:active_workspace(),
		wezterm.strftime("%a %b %-d %H:%M"),
		wezterm.hostname(),
	}
end

wezterm.on("update-status", function(window, _)
	local SOLID_LEFT_ARROW = utf8(0xE0B2)
	local segments = segments_for_right_status(window)

	local color_scheme = window:effective_config().resolved_palette
	-- Note the use of wezterm.color.parse here, this returns
	-- a Color object, which comes with functionality for lightening
	-- or darkening the colour (amongst other things).
	local bg = wezterm.color.parse(color_scheme.background)
	local fg = color_scheme.foreground

	-- Each powerline segment is going to be coloured progressively
	-- darker/lighter depending on whether we're on a dark/light colour
	-- scheme. Let's establish the "from" and "to" bounds of our gradient.
	local gradient_to, gradient_from = bg, nil
	gradient_from = gradient_to:lighten(0.2)

	-- Yes, WezTerm supports creating gradients, because why not?! Although
	-- they'd usually be used for setting high fidelity gradients on your terminal's
	-- background, we'll use them here to give us a sample of the powerline segment
	-- colours we need.
	local gradient = wezterm.color.gradient(
		{
			orientation = "Horizontal",
			colors = { gradient_from, gradient_to },
		},
		#segments -- only gives us as many colours as we have segments.
	)

	-- We'll build up the elements to send to wezterm.format in this table.
	local elements = {}

	for i, seg in ipairs(segments) do
		local is_first = i == 1

		if is_first then
			table.insert(elements, { Background = { Color = "none" } })
		end
		table.insert(elements, { Foreground = { Color = gradient[i] } })
		table.insert(elements, { Text = SOLID_LEFT_ARROW })

		table.insert(elements, { Foreground = { Color = fg } })
		table.insert(elements, { Background = { Color = gradient[i] } })
		table.insert(elements, { Text = " " .. seg .. " " })
	end

	window:set_right_status(wezterm.format(elements))
end)
