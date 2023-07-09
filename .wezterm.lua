-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Cobalt Neon'
config.window_background_opacity = 0.95
config.front_end = "OpenGL"
config.font = wezterm.font 'Inconsolata Nerd Font Mono'
config.font_size = 11.0
config.hide_tab_bar_if_only_one_tab = true


-- and finally, return the configuration to wezterm
return config
