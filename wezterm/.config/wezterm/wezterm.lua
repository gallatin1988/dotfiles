local wezterm = require 'wezterm'
-- local mux = wezterm.mux
-- local config = {}

-- wezterm.on('gui-startup', function(cmd)
--	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	window:gui_window():maximize()
-- end)
local config= wezterm.config_builder()
-- config.window.maximize()
-- config.color_scheme = 'Gruvbox Dark (Gogh)'
config.color_scheme = 'Catppuccin Mocha'
config.font =
	wezterm.font('JetBrains Mono', { weight = 'Regular', stretch = 'Normal', style = 'Normal' })
config.font_size = 12.0
config.enable_tab_bar = false
config.window_close_confirmation = 'NeverPrompt'
config.window_background_opacity = 1.0
config.macos_window_background_blur = 30
config.default_prog = { 'tmux' }
config.window_decorations = 'RESIZE'
config.scrollback_lines= 3500
config.keys = {
		{
			key = 'f',
			mods = 'CTRL',
			action = wezterm.action.ToggleFullScreen,
		},
		{ 
			key = 'q',
			mods = 'CTRL',
			action = wezterm.action.QuitApplication
		},
		{
			key = '\'',
			mods = 'CTRL',
			action = wezterm.action.ClearScrollback 'ScrollbackAndViewport',
		},
	}
config.mouse_bindings = {
	  -- Ctrl-click will open the link under the mouse cursor
	  {
	  	event = { Up = { streak = 1, button = 'Left' } },
	  	mods = 'CTRL',
	  	action = wezterm.action.OpenLinkAtMouseCursor,
	  },
	}
return config
	-- color_scheme = 'termnial.sexy',
	
	
	
	-- font = wezterm.font 'JetBrains Mono',
	-- macos_window_background_blur = 40,
	
	
	-- window_background_image = '/Users/omerhamerman/Downloads/3840x1080-Wallpaper-041.jpg',
	-- window_background_image_hsb = {
	-- 	brightness = 0.01,
	-- 	hue = 1.0,
	-- 	saturation = 0.5,
	-- },
	-- window_background_opacity = 0.92,
	-- window_background_opacity = 1.0,
	
	-- window_background_opacity = 0.78,
	-- window_background_opacity = 0.20,
	
