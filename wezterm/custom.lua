local c = {
	rosewater = "#efc9c2",
	flamingo = "#ebb2b2",
	pink = "#f2a7de",
	mauve = "#b889f4",
	red = "#fc5153",
	maroon = "#ea838c",
	peach = "#f28500",
	yellow = "#fcf75e",
	green = "#03c03c",
	teal = "#3ab09e",
	sky = "#00bfff",
	sapphire = "#0067a5",
	blue = "#739df2",
	lavender = "#b6a8f6",
	text = "#c5d1f1",
	subtext1 = "#a6b0d8",
	subtext0 = "#959eb2",
	overlay2 = "#848c8d",
	overlay1 = "#717997",
	overlay0 = "#966371",
	surface2 = "#505469",
	surface1 = "#3e4255",
	surface0 = "#2c2f40",
	base = "#0e0f16",
	mantle = "#141620",
	crust = "#999999",
	dark_crust = "#5f5f5f",
	transparent = "rgb(0% 0% 0% 0%)",
}

return {
	c = c,
	colors = {
		foreground = c.text,
		background = c.base,
		cursor_bg = c.overlay1,
		cursor_fg = c.mantle,
		cursor_border = c.text,
		selection_bg = c.pink,
		selection_fg = c.base,
		scrollbar_thumb = c.crust,
		split = c.surface2,
		compose_cursor = c.peach,
	},
}