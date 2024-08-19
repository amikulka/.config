local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Monoakai Remastered"
config.font_size = 12.0
config.enable_csi_u_key_encoding = true
config.hide_tab_bar_if_only_one_tab = true

return config
