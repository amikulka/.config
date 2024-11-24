require("tab_bar")
local wezterm = require("wezterm")
local sessionizer = require("sessionizer")

local custom = require("custom")

local act = wezterm.action

local function update_config(window)
	local overrides = window:get_config_overrides() or {}
	local tabs = window:mux_window():tabs()
	if #tabs > 1 then
		overrides.show_tabs_in_tab_bar = true
	else
		overrides.show_tabs_in_tab_bar = false
	end
	window:set_config_overrides(overrides)
end

-- Event handler for updating the configuration
wezterm.on("update-status", function(window)
	update_config(window)
end)

return {
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 3000 },
	colors = custom.colors,
	initial_rows = 50,
	initial_cols = 200,
	window_frame = {
		font_size = 13.0,
		active_titlebar_bg = "rgba(0% 0% 0% 0%)",
		inactive_titlebar_bg = "rgba(0% 0% 0% 0%)",
	},
	-- color_scheme = "Ubuntu",
	-- color_scheme = "Monokai Vivid",
	show_new_tab_button_in_tab_bar = false,
	show_close_tab_button_in_tabs = false,

	default_workspace = "~/",
	audible_bell = "Disabled",
	inactive_pane_hsb = {
		hue = 0.9,
		saturation = 0.8,
		brightness = 0.3,
	},
	term = "wezterm",

	disable_default_key_bindings = true,
	keys = {
		{ key = "h", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Left") },
		{ key = "l", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Right") },
		{ key = "k", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Up") },
		{ key = "j", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Down") },
		{ key = "h", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "l", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "k", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "j", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
		{ key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
		{ key = "Enter", mods = "SHIFT|CTRL", action = act.ToggleFullScreen },
		{ key = "_", mods = "SHIFT|CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "/", mods = "SHIFT|CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "c", mods = "SHIFT|CTRL", action = act.CloseCurrentPane({ confirm = false }) },
		{ key = "1", mods = "SUPER", action = act.ActivateTab(0) },
		{ key = "2", mods = "SUPER", action = act.ActivateTab(1) },
		{ key = "3", mods = "SUPER", action = act.ActivateTab(2) },
		{ key = "4", mods = "SUPER", action = act.ActivateTab(3) },
		{ key = "5", mods = "SUPER", action = act.ActivateTab(4) },
		{ key = "6", mods = "SUPER", action = act.ActivateTab(5) },
		{ key = "7", mods = "SUPER", action = act.ActivateTab(6) },
		{ key = "8", mods = "SUPER", action = act.ActivateTab(7) },
		{ key = "9", mods = "SUPER", action = act.ActivateTab(8) },
		{ key = "D", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
		{ key = "P", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
		{ key = "R", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
		{ key = "W", mods = "SHIFT|CTRL", action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "X", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
		{ key = "Z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState }, -- Full screen current split pane
		{ key = "_", mods = "SUPER", action = act.DecreaseFontSize },
		{ key = "Enter", mods = "SUPER", action = act.IncreaseFontSize },
		{ key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
		{ key = "f", mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "k", mods = "SUPER", action = act.ClearScrollback("ScrollbackOnly") },
		{ key = "m", mods = "SUPER", action = act.Hide },
		{ key = "n", mods = "SUPER", action = act.SpawnWindow },
		{ key = "q", mods = "SUPER", action = act.QuitApplication },
		{ key = "d", mods = "SUPER", action = act.DetachDomain("CurrentPaneDomain") },
		{ key = "r", mods = "SUPER", action = act.ReloadConfiguration },
		{ key = "t", mods = "SUPER", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
		{ key = "w", mods = "SUPER", action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "x", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
		{ key = "z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
		{ key = "phys:Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
		{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
		{ key = "PageUp", mods = "CTRL", action = act.ActivateTabRelative(-1) },
		{ key = "PageUp", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
		{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
		{ key = "PageDown", mods = "CTRL", action = act.ActivateTabRelative(1) },
		{ key = "PageDown", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },
		{ key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
		{ key = "Paste", mods = "NONE", action = act.PasteFrom("Clipboard") },
		{ key = "f", mods = "CTRL", action = wezterm.action_callback(sessionizer.toggle) },
		{ key = "s", mods = "CTRL", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
		{ key = "d", mods = "LEADER", action = act.ShowDebugOverlay },
	},

	key_tables = {
		copy_mode = {
			{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{ key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "Space", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
			{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
			{ key = "F", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "F", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
			{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
			{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "T", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "T", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
			{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
			{ key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
			{ key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
			{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
			{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
			{ key = "g", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
			{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "t", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
			{ key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
			{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
			{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{
				key = "y",
				mods = "NONE",
				action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),
			},
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
			{ key = "End", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "Home", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
		},

		search_mode = {
			{ key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
			{ key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
			{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
			{ key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PriorMatchPage") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("NextMatchPage") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("NextMatch") },
		},
	},
}
