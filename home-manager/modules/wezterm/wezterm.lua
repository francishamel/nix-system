local wezterm = require("wezterm")
local config = wezterm.config_builder()

wezterm.on("gui-startup", function()
	local tab, pane, window = wezterm.mux.spawn_window({})
	window:gui_window():maximize()
end)

config.enable_tab_bar = false
config.front_end = "WebGpu"
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

return config
