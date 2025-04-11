-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Gruvbox"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 10.5

config.default_prog = { "pwsh.exe" }

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.7

-- and finally, return the configuration to wezterm
return config
