-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- config.default_domain = "WSL:Ubuntu"

-- This is the font we will use for the terminal
-- config.font = wezterm.font 'Hack Nerd Font'
-- config.font = wezterm.font 'UbuntuMono Nerd Font Mono'
-- config.font = wezterm.font 'BerkeleyMonoVariable Nerd Font Mono'
-- config.font = wezterm.font 'FiraCode Nerd Font Mono'
-- config.font = wezterm.font 'VictorMono NF'
-- config.font = wezterm.font 'JetBrainsMono Nerd Font Mono'
-- config.font = wezterm.font 'GohuFont uni14 Nerd Font'
config.font = wezterm.font 'Ubuntu Mono'
-- config.font = wezterm.font 'Input Mono'
-- config.font = wezterm.font '0xProto'
-- config.font = wezterm.font 'GohuFont'
config.font_size = 16

-- For example, changing the color scheme:
config.color_scheme = "Gruvbox dark, hard (base16)"
config.enable_scroll_bar = true
config.enable_tab_bar = false
config.window_padding = { left = 0, right = -5, top = 0, bottom = 0 }
config.audible_bell = "Disabled"
config.window_decorations = "RESIZE"


local gpus = wezterm.gui.enumerate_gpus()
for _, gpu in ipairs(gpus) do
	if gpu.backend == "Vulkan" and gpu.device_type == "DiscreteGPU" then
		config.webgpu_preferred_adapter = gpu
		config.front_end = "WebGpu"
		break
	end
end

-- config.webgpu_preferred_adapter = gpus[1]
-- config.webgpu_preferred_adapter = {
-- 	backend = "Vulkan",
-- 	device = 9437,
-- 	device_type = "DiscreteGPU",
-- 	driver = "NVIDIA",
-- 	driver_info = "561.09",
-- 	name = "NVIDIA GeForce RTX 3070 Laptop GPU",
-- 	vendor = 4318,
-- }
-- config.front_end = "WebGpu"

config.keys = {
	{ key = 'K', mods = 'CTRL', action = wezterm.action.ShowDebugOverlay },
}

-- Toggle window "RESIZE" and "NONE" state decorations
-- config.keys = {
-- 	{
-- 		key = 'x',
-- 		mods = 'CTRL',
-- 		action = wezterm.action_callback(function(window)
-- 			local overrides = window:get_config_overrides()
-- 			if overrides.window_decorations == 'RESIZE' then
-- 				overrides.window_decorations = 'NONE'
-- 			else
-- 				overrides.window_decorations = 'RESIZE'
-- 			end
--
-- 			wezterm.reload_configuration()
-- 		end)
-- 	},
-- }

-- and finally, return the configuration to wezterm
return config
