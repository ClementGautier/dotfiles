local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "rose-pine-moon"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 9.0
config.enable_wayland = false
config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = "Disabled"

return config
