local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"
config.font_size = 13
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.automatically_reload_config = false
config.swallow_mouse_click_on_window_focus = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.adjust_window_size_when_changing_font_size = false

config.keys = {
	{
		key = "F11",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "+",
		mods = "CTRL",
		action = wezterm.action.IncreaseFontSize,
	},
	{
		key = "-",
		mods = "CTRL",
		action = wezterm.action.DecreaseFontSize,
	},
	{
		key = "=",
		mods = "CTRL",
		action = wezterm.action.ResetFontSize,
	},
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	{
		key = "\\",
		mods = "CTRL",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		key = "Backspace",
		mods = "CTRL",
		action = wezterm.action.SendKey({ mods = "CTRL", key = "w" }),
	},
}

config.char_select_font_size = 13
config.char_select_fg_color = "#cdd6f4"
config.char_select_bg_color = "#1e1e2e"

config.selection_word_boundary = " \t\n{}[]()\"'`,;:@│┃*…$"
config.audible_bell = "Disabled"
config.hide_tab_bar_if_only_one_tab = true

config.default_cursor_style = "SteadyBar"

local home_dir
local path_separator = "\\"
local path_env = os.getenv("PATH")

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	home_dir = os.getenv("USERPROFILE")
	config.default_prog =
		{ "cmd.exe", "/s", "/k", "clink inject -q && " .. home_dir .. "\\dotfiles" .. "\\doskeys.cmd" }
else
	config.default_prog = { "zsh" }
	home_dir = os.getenv("HOME")
	path_separator = "/"
end

local dotfiles_dir = home_dir .. path_separator .. "dotfiles"

config.default_cwd = home_dir .. path_separator .. "repos"

config.set_environment_variables = {
	DOTS = home_dir .. path_separator .. "dotfiles",
	REPO = home_dir .. path_separator .. "repos",
	RAND = home_dir .. path_separator .. "random",
	PATH = path_env .. ";" .. dotfiles_dir .. path_separator .. "scripts",
	EDITOR = "nvim",
	FZF_CTRL_T_COMMAND = "eza --oneline --absolute --color=always --no-quotes $dir",
	CLINK_PATH = dotfiles_dir .. path_separator .. "scripts",
	CLINK_SETTINGS = dotfiles_dir,
	GIT_CONFIG_GLOBAL = dotfiles_dir .. path_separator .. "git.ini",
	YAZI_CONFIG_HOME = dotfiles_dir,
	LG_CONFIG_FILE = dotfiles_dir .. path_separator .. "lazygit.yml",
	FZF_DEFAULT_OPTS = "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --color=selected-bg:#45475a --multi --ansi",
}

return config
