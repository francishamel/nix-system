local wezterm = require("wezterm")

wezterm.on("gui-startup", function()
	local tab, pane, window = wezterm.mux.spawn_window({})
	window:gui_window():maximize()
end)

local config = wezterm.config_builder()

config.audible_bell = "Disabled"
config.color_scheme = "nord"
config.enable_tab_bar = false
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 14.0
config.front_end = "WebGpu"
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

local act = wezterm.action

config.keys = {
	{
		key = "LeftArrow",
		mods = "OPT",
		action = act.SendKey({
			key = "b",
			mods = "ALT",
		}),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = act.SendKey({
			key = "f",
			mods = "ALT",
		}),
	},
	{
		key = "LeftArrow",
		mods = "CMD",
		action = act.SendKey({
			key = "a",
			mods = "CTRL",
		}),
	},
	{
		key = "RightArrow",
		mods = "CMD",
		action = act.SendKey({
			key = "e",
			mods = "CTRL",
		}),
	},
	{
		key = "Backspace",
		mods = "OPT",
		action = act.SendKey({
			key = "w",
			mods = "CTRL",
		}),
	},
	{
		key = "Backspace",
		mods = "CMD",
		action = act.SendKey({
			key = "u",
			mods = "CTRL",
		}),
	},
}

return config
