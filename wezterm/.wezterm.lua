local wezterm = require 'wezterm'

local config = {}

config.color_scheme = 'Catppuccin Frappe'
config.font = wezterm.font("Recursive Monospace Casual")
config.font_size = 15.0
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
-- config.tab_bar_at_bottom = true

return config
