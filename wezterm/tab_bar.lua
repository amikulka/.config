local wezterm = require("wezterm")
local c = require("custom").c

local SOLID_LEFT_FLAME = wezterm.nerdfonts.ple_flame_thick_mirrored
local SOLID_RIGHT_FLAME = wezterm.nerdfonts.ple_flame_thick

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = c.transparent
	local foreground = c.overlay2
	local edge_foreground = c.transparent

	if tab.is_active then
		edge_foreground = c.red
		foreground = c.text
	elseif hover then
		edge_foreground = c.sapphire
		foreground = c.crust
	end

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_FLAME },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = "  " .. title .. "  " },
		{ Background = { Color = background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_FLAME },
	}
end)

wezterm.on("update-right-status", function(window)
	local workspace = window:active_workspace()
	local status = "Workspace: " .. workspace
	if window:leader_is_active() then
		status = "LEADER  |  " .. workspace
	end
	local formatted_status = {
		{ Background = { Color = c.transparent } },
		{ Foreground = { Color = c.red } },
		{ Text = SOLID_LEFT_FLAME },
		{ Background = { Color = c.base } },
		{ Foreground = { Color = c.text } },
		{ Text = "    " .. status .. "    " },
		{ Background = { Color = c.transparent } },
		{ Foreground = { Color = c.red } },
		{ Text = SOLID_RIGHT_FLAME },
	}
	window:set_right_status(wezterm.format(formatted_status))
end)

return {}
