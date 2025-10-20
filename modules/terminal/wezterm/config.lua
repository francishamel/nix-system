local wezterm = require("wezterm")

local mux = wezterm.mux
local act = wezterm.action
local config = wezterm.config_builder()

wezterm.on("gui-startup", function()
	---@diagnostic disable-next-line: unused-local
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

config.audible_bell = "Disabled"

config.color_scheme = "nord"

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 14.0

config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

-- TODO: enable this config option when available outside of nightly build
-- config.show_close_tab_button_in_tabs = false
config.show_new_tab_button_in_tab_bar = false

config.disable_default_key_bindings = true

config.keys = {
	{ key = "LeftArrow", mods = "OPT", action = act.SendKey({ key = "b", mods = "ALT" }) },
	{ key = "RightArrow", mods = "OPT", action = act.SendKey({ key = "f", mods = "ALT" }) },
	{ key = "LeftArrow", mods = "CMD", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "RightArrow", mods = "CMD", action = act.SendKey({ key = "e", mods = "CTRL" }) },
	{ key = "Backspace", mods = "OPT", action = act.SendKey({ key = "w", mods = "CTRL" }) },
	{ key = "Backspace", mods = "CMD", action = act.SendKey({ key = "u", mods = "CTRL" }) },

	{ key = "d", mods = "CMD", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "r", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	{ key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },

	{ key = "h", mods = "CMD", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CMD", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CMD", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CMD", action = act.ActivatePaneDirection("Right") },

	{ key = "h", mods = "CMD|SHIFT", action = act.ActivateTabRelativeNoWrap(-1) },
	{ key = "l", mods = "CMD|SHIFT", action = act.ActivateTabRelativeNoWrap(1) },

	{ key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "w", mods = "CMD|SHIFT", action = act.CloseCurrentTab({ confirm = false }) },
	{ key = "q", mods = "CMD", action = act.QuitApplication },

	{ key = "p", mods = "CMD|SHIFT", action = act.ActivateCommandPalette },

	{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },

	{ key = "=", mods = "CMD", action = act.IncreaseFontSize },
	{ key = "-", mods = "CMD", action = act.DecreaseFontSize },
	{ key = "0", mods = "CMD", action = act.ResetFontSize },
}

return config
