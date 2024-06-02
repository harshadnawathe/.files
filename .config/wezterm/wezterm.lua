local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.term = "wezterm"

config.color_scheme = "Catppuccin Mocha"

config.background = {
	{
		source = {
			File = {
				path = os.getenv("HOME")
					.. "/.config/wezterm/wallpapers/darth-vader-red-lightsaber-star-wars-moewalls-com.gif",
			},
		},
		hsb = { brightness = 0.2 },
		horizontal_align = "Center",
		vertical_align = "Middle",
	},
}

config.font = wezterm.font_with_fallback({
	{ family = "Monaspace Neon", weight = 500 },
	{ family = "Symbols Nerd Font", scale = 1.2 },
})

config.font_size = 16

config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.adjust_window_size_when_changing_font_size = false

config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
}

config.initial_cols = 180
config.initial_rows = 50

config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
	{
		event = { Up = { streak = 1, button = "Right" } },
		action = wezterm.action.PasteFrom("PrimarySelection"),
	},
}

local k = require("utils.keys")

config.keys = {
	-- Tmux Panes
	k.cmd_to_tmux_prefix("d", "|"),
	k.cmd_to_tmux_prefix("D", "-"),

	-- Tmux Panes - arrow navigation
	k.cmd_to_tmux_prefix("LeftArrow", "h"),
	k.cmd_to_tmux_prefix("RightArrow", "l"),
	k.cmd_to_tmux_prefix("UpArrow", "k"),
	k.cmd_to_tmux_prefix("DownArrow", "j"),

	-- Tmux Tabs
	k.cmd_to_tmux_prefix("t", "c"),
	k.cmd_to_tmux_prefix("T", "&"),

	k.cmd_to_tmux_prefix("o", "a"),
	k.cmd_to_tmux_prefix("p", "p"),
	k.cmd_to_tmux_prefix("n", "n"),

	-- Tmux Tabs - quick select
	k.cmd_to_tmux_prefix("0", "0"),
	k.cmd_to_tmux_prefix("1", "1"),
	k.cmd_to_tmux_prefix("2", "2"),
	k.cmd_to_tmux_prefix("3", "3"),
	k.cmd_to_tmux_prefix("4", "4"),
	k.cmd_to_tmux_prefix("5", "5"),
	k.cmd_to_tmux_prefix("6", "6"),
	k.cmd_to_tmux_prefix("7", "7"),
	k.cmd_to_tmux_prefix("8", "8"),
	k.cmd_to_tmux_prefix("9", "9"),

	-- Tmux sessions
	k.cmd_to_tmux_prefix("O", "S"),
	k.cmd_to_tmux_prefix("N", ")"),
	k.cmd_to_tmux_prefix("P", "("),

	-- Tmux VI mode
	k.cmd_to_tmux_prefix("S", "["),

	-- Tmux fzf url
	k.cmd_to_tmux_prefix("u", "u"),
}

config.default_prog = {
	"/opt/homebrew/bin/tmux",
	"new-session",
	"-A",
	"-D",
	"-s",
	"__",
}

return config
