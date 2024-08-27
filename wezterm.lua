local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Define mods helper, to have a short way to create mods values
-- (e.g: mods._ for NONE, mods.CA for CTRL|ALT)
local mods = setmetatable({
	_SHORT_MOD_MAP = {
		_ = "NONE",
		C = "CTRL",
		S = "SHIFT",
		A = "ALT",
		D = "SUPER", -- D for Desktop (Win/Cmd/Super)
	},
}, {
	-- Dynamically transform key access of 'CSA' to 'CTRL|SHIFT|ALT'
	__index = function(self, key)
		local resolved_mods = self._SHORT_MOD_MAP[key:sub(1, 1)]
		for i = 2, #key do
			local char = key:sub(i, i)
			resolved_mods = resolved_mods .. "|" .. self._SHORT_MOD_MAP[char]
		end
		return resolved_mods
	end,
})

local is_list = function(t)
	if type(t) ~= "table" then
		return false
	end
	-- a list has list indices, an object does not
	return ipairs(t)(t, 0) and true or false
end

--- Flatten the given list of (item or (list of (item or ...)) to a list of item.
-- (nested lists are supported)
local function flatten_list(list)
	local flattened_list = {}
	for _, item in ipairs(list) do
		if is_list(item) then
			for _, sub_item in ipairs(flatten_list(item)) do
				table.insert(flattened_list, sub_item)
			end
		else
			table.insert(flattened_list, item)
		end
	end
	return flattened_list
end

config.color_scheme = "Catppuccin Mocha"
config.font_size = 014
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.automatically_reload_config = false
config.disable_default_mouse_bindings = true
config.swallow_mouse_click_on_window_focus = true

local mouse_bindings = {}

local function binds_for_mouse_actions(mouse_actions_mods, button, streak, mouse_actions, extra_opts)
	local function mouse_bind_for(event_kind, action)
		local bind = {
			mods = mouse_actions_mods,
			event = {
				[event_kind] = {
					streak = streak,
					button = button,
				},
			},
			action = action,
		}
		for k, v in pairs(extra_opts or {}) do
			bind[k] = v
		end
		return bind
	end

	local binds = {}
	if mouse_actions.down_action then
		table.insert(binds, mouse_bind_for("Down", mouse_actions.down_action))
	end
	if mouse_actions.drag_action then
		table.insert(binds, mouse_bind_for("Drag", mouse_actions.drag_action))
	end
	if mouse_actions.up_action then
		table.insert(binds, mouse_bind_for("Up", mouse_actions.up_action))
	end
	return binds
end

local function initial_selection_mouse_actions(selection_mode)
	return {
		-- Select on Down event
		down_action = wezterm.action.SelectTextAtMouseCursor(selection_mode),
		-- Extend on Drag event
		drag_action = wezterm.action.ExtendSelectionToMouseCursor(selection_mode),
		-- Complete & Copy on Up event
		up_action = wezterm.action.CompleteSelection("ClipboardAndPrimarySelection"),
	}
end
-- Left click always starts a new selection.
-- The number of clicks determines the selection mode: 1:Cell 2:Word: 3:Line & Alt+1:Block
table.insert(mouse_bindings, {
	binds_for_mouse_actions(mods._, "Left", 1, initial_selection_mouse_actions("Cell")),
	binds_for_mouse_actions(mods._, "Left", 2, initial_selection_mouse_actions("Word")),
	binds_for_mouse_actions(mods._, "Left", 3, initial_selection_mouse_actions("Line")),
	binds_for_mouse_actions(mods.A, "Left", 1, initial_selection_mouse_actions("Block")),
})

local function extend_selection_mouse_actions(selection_mode)
	return {
		-- Extend the selection on Down & Drag events
		down_action = wezterm.action.ExtendSelectionToMouseCursor(selection_mode),
		drag_action = wezterm.action.ExtendSelectionToMouseCursor(selection_mode),
		-- Complete & Copy on Up event
		up_action = wezterm.action.CompleteSelection("ClipboardAndPrimarySelection"),
	}
end
-- Right click always extends the selection.
-- The number of clicks determines the selection mode: 1:Cell 2:Word: 3:Line & Alt+1:Block
table.insert(mouse_bindings, {
	binds_for_mouse_actions(mods._, "Right", 1, extend_selection_mouse_actions("Cell")),
	binds_for_mouse_actions(mods._, "Right", 2, extend_selection_mouse_actions("Word")),
	binds_for_mouse_actions(mods._, "Right", 3, extend_selection_mouse_actions("Line")),
	binds_for_mouse_actions(mods.A, "Right", 1, extend_selection_mouse_actions("Block")),
})

-- Ctrl-Left click (on Up) opens the link under the mouse pointer if any.
-- (on Down, the click is disabled. This is to avoid bugging the running
-- program which would receive _only_ the down event and not the up event)
table.insert(mouse_bindings, {
	binds_for_mouse_actions(mods.C, "Left", 1, {
		down_action = wezterm.action.Nop,
		up_action = wezterm.action.OpenLinkAtMouseCursor,
	}),
	-- Also enable this binding when mouse reporting is enabled.
	binds_for_mouse_actions(mods.C, "Left", 1, {
		down_action = wezterm.action.Nop,
		up_action = wezterm.action.OpenLinkAtMouseCursor,
	}, { mouse_reporting = true }), -- note the extra binding options
})

-- Clipboard
table.insert(mouse_bindings, {
	-- Middle click pastes
	wezterm.permute_any_or_no_mods({
		event = { Down = { streak = 1, button = "Middle" } },
		action = wezterm.action.PasteFrom("Clipboard"),
	}),
	-- Also enable this binding when mouse reporting is enabled.
	wezterm.permute_any_or_no_mods({
		mouse_reporting = true,
		event = { Down = { streak = 1, button = "Middle" } },
		action = wezterm.action.PasteFrom("Clipboard"),
	}),
})

-- Scrolling!
-- Since 20220807-113146-c2fee766 the WheelUp/WheelDown events can be bound to
-- custom actions. When using `disable_default_mouse_bindings=true`, scrolling is (almost)
-- completely disabled and we need to enable it again.
-- NOTE: There is still a builtin behavior when alt_screen=true that auto-sends up/down arrows to
-- simulate scrolling. No need to bind this myself.
table.insert(mouse_bindings, {
	{
		mods = mods._,
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		action = wezterm.action.ScrollByCurrentEventWheelDelta,
		alt_screen = false, -- ⚠⚠⚠ important, scroll on alt-screen will auto-send arrows
	},
	{
		mods = mods._,
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		action = wezterm.action.ScrollByCurrentEventWheelDelta,
		alt_screen = false, -- ⚠⚠⚠ important, scroll on alt-screen will auto-send arrows
	},
})

-- To simplify config composability, `mouse_bindings` is a
-- nested list of (bind or list of (bind or ...)), so we must
-- flatten the list first.
config.mouse_bindings = flatten_list(mouse_bindings)

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Helper for keybind definition
local function keybind(keybind_mods, keybind_keys, keybind_action)
	local keys = (type(keybind_keys) == "table") and keybind_keys or { keybind_keys }
	local keybind_mods_copy = keybind_mods
	local binds = {}
	for _, key in ipairs(keys) do
		table.insert(binds, { mods = keybind_mods_copy, key = key, action = keybind_action })
	end
	return binds
end

config.disable_default_key_bindings = true

config.key_tables = {}
local function define_and_activate_keytable(spec)
	-- Flatten keys, and define the Key Table
	config.key_tables[spec.name] = flatten_list(spec.keys)

	-- Setup & return activation key bind
	local activation_opts = spec.activation or {}
	activation_opts.name = spec.name
	return wezterm.action.ActivateKeyTable(activation_opts)
end

-- Raw key codes are hardware & OS/WM dependent, so they're not really portable..
-- https://wezfurlong.org/wezterm/config/keys.html#raw-key-assignments
-- local known_raw_keys_by_os = {
-- 	["^"] = { linux = "raw:34", win = nil },
-- }
-- local function get_raw_key(keysym)
-- 	local target_triple_to_os = {
-- 		["x86_64-pc-windows-msvc"] = "windows",
-- 		["x86_64-unknown-linux-gnu"] = "linux",
-- 	}
-- 	local os = target_triple_to_os[wezterm.target_triple]
-- 	assert(
-- 		os,
-- 		"Unknown os for getting raw key keysym:"
-- 			.. tostring(keysym)
-- 			.. " (target_triple:"
-- 			.. tostring(wezterm.target_triple)
-- 			.. ")"
-- 	)
-- 	local key_by_os = known_raw_keys_by_os[keysym]
-- 	assert(key_by_os, "Unknown keysym:" .. tostring(keysym))
-- 	local key_raw = key_by_os[os]
-- 	assert(key_raw, "Unknown raw key for keysym:" .. tostring(keysym) .. " os:" .. tostring(os))
-- 	return key_raw
-- end

-- NOTE: About SHIFT and the keybind definition:
-- * For bindings with SHIFT and a letter, the `key` field (the letter)
--   can be lowercase and the mods should NOT contain 'SHIFT'.
-- * For bindings with SHIFT and something else, mod should contain SHIFT,
--   and key should be the shifted key that is going to reach the terminal.
--   (based on the keyboard-layout)
config.keys = flatten_list({
	-- Remap C-Backspace to C-w everywhere
	keybind(mods.C, "Backspace", wezterm.action.SendKey({ mods = mods.C, key = "w" })),
	-- Remap A-^/$ to Home/End globally
	-- NOTE: Mapped via raw key code to bypass waiting for dead key handling (like ^e -> ê)
	-- (could also be done at system/desktop level, but this is a good level for all terminal apps)
	keybind(mods.A, "^", wezterm.action.SendKey({ key = "Home" })),
	keybind(mods.A, "$", wezterm.action.SendKey({ key = "End" })),
	-- Force map `Alt-^` itself to terminal program (like neovim!).
	-- NOTE: Mapped via raw key code to bypass waiting for dead key handling (like ^e -> ê)
	--keybind(mods.A, get_raw_key("^"), act.SendKey{mods=mods.A, key="^"}),

	keybind(mods.S, "PageUp", wezterm.action.ScrollByPage(-1)),
	keybind(mods.S, "PageDown", wezterm.action.ScrollByPage(1)),

	-- keybind(mods.CS, "r", act.ReloadConfiguration),
	keybind(mods.CS, "r", wezterm.action.EmitEvent("my-reload-config-with-notif")),

	keybind(mods.CS, "l", wezterm.action.ClearScrollback("ScrollbackAndViewport")),
	keybind(mods.CS, "d", wezterm.action.ShowDebugOverlay),
	keybind(mods.CS, "y", wezterm.action.ActivateCopyMode),
	-- note: last search is now prefilled, may need to clear it first with Ctrl-u
	keybind(mods.CS, "f", wezterm.action.Search({ CaseInSensitiveString = "" })),

	-- Copy/Paste to/from Clipboard
	keybind(mods.CS, "c", wezterm.action.CopyTo("ClipboardAndPrimarySelection")),
	keybind(mods.CS, "v", wezterm.action.PasteFrom("Clipboard")),
	keybind(mods.CA, "v", wezterm.action.PasteFrom("Clipboard")), -- note: eats a valid term input
	-- Paste from PrimarySelection
	keybind(mods.S, "Insert", wezterm.action.PasteFrom("PrimarySelection")),

	-- Smart copy with Alt-c:
	-- - If active selection, will copy it to Clipboard & Primary
	-- - If NO selection, sends Alt-c to the running program (which may do a copy in context)
	keybind(
		mods.A,
		"c",
		wezterm.action_callback(function(win, pane)
			local has_selection = win:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				win:perform_action(wezterm.action.CopyTo("ClipboardAndPrimarySelection"), pane)
			else
				win:perform_action(wezterm.action.SendKey({ mods = mods.A, key = "c" }), pane)
			end
		end)
	),

	-- Tabs
	keybind(mods.CS, "t", wezterm.action.SpawnTab("DefaultDomain")),
	keybind(mods.C, "Tab", wezterm.action.ActivateTabRelative(1)),
	keybind(mods.CS, "Tab", wezterm.action.ActivateTabRelative(-1)),
	-- keybind(mods.CS, "w", act.CloseCurrentTab{confirm=false}),

	keybind(mods.CS, "x", wezterm.action.ShowLauncher),
	keybind(mods.CS, "p", wezterm.action.ActivateCommandPalette),
	keybind(mods.CS, "c", wezterm.action.CharSelect),

	-- Font size
	keybind(mods.C, "0", wezterm.action.ResetFontSize), -- Ctrl-Shift-0
	keybind(mods.C, "+", wezterm.action.IncreaseFontSize), -- Ctrl-Shift-+ (key with +)
	keybind(mods.C, "6", wezterm.action.DecreaseFontSize), -- Ctrl-Shift-- (key with -)
	-- On Windows, the Shift modifier seems to not be removed for these ^ shifted keys,
	-- so I may have to add SHIFT.

	-- Toggle font ligatures
	keybind(
		mods.CS,
		"g",
		wezterm.action_callback(function(win, _)
			local overrides = win:get_config_overrides() or {}
			if not overrides.harfbuzz_features then
				-- If we haven't overriden it yet, then override with ligatures disabled
				overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
			else
				-- else we did already, and we should disable the override now
				overrides.harfbuzz_features = nil
			end
			win:set_config_overrides(overrides)
		end)
	),

	keybind(
		mods.CS,
		"Space",
		define_and_activate_keytable({
			name = "Leader",
			-- Make this layer volatile, easily dismissed
			activation = { one_shot = true, until_unknown = true },
			keys = {
				-- Safe key table exit
				keybind(mods._, "Escape", wezterm.action.PopKeyTable),
				-- Trigger repeated!
				keybind(mods.CS, "Space", wezterm.action.QuickSelect),

				keybind(mods.C, "v", wezterm.action.PasteFrom("Clipboard")),

				keybind(
					mods._,
					"f",
					define_and_activate_keytable({
						name = "font size",
						activation = { one_shot = false },
						keys = {
							keybind(mods._, "Escape", wezterm.action.PopKeyTable),
							keybind(mods._, "j", wezterm.action.DecreaseFontSize),
							keybind(mods._, "k", wezterm.action.IncreaseFontSize),
							keybind(mods._, "r", wezterm.action.ResetFontSize),
						},
					})
				),

				-- Key Table: Panes Management
				keybind(
					mods.CS,
					"p",
					define_and_activate_keytable({
						name = "my-panes-management",
						activation = { one_shot = false },
						keys = {
							keybind(mods._, "Escape", wezterm.action.PopKeyTable),
							keybind(mods.CS, "p", wezterm.action.PopKeyTable),

							-- Create
							keybind(mods.CSA, { "h", "LeftArrow" }, wezterm.action.SplitPane({ direction = "Left" })),
							keybind(mods.CSA, { "j", "DownArrow" }, wezterm.action.SplitPane({ direction = "Down" })),
							keybind(mods.CSA, { "k", "UpArrow" }, wezterm.action.SplitPane({ direction = "Up" })),
							keybind(mods.CSA, { "l", "RightArrow" }, wezterm.action.SplitPane({ direction = "Right" })),
							-- Destroy
							keybind(mods.CS, "d", wezterm.action.CloseCurrentPane({ confirm = true })),

							-- Navigation
							keybind(mods.CS, { "h", "LeftArrow" }, wezterm.action.ActivatePaneDirection("Left")),
							keybind(mods.CS, { "j", "DownArrow" }, wezterm.action.ActivatePaneDirection("Down")),
							keybind(mods.CS, { "k", "UpArrow" }, wezterm.action.ActivatePaneDirection("Up")),
							keybind(mods.CS, { "l", "RightArrow" }, wezterm.action.ActivatePaneDirection("Right")),
							keybind(mods.CS, "Space", wezterm.action.PaneSelect({ mode = "Activate" })),

							-- Manipulation
							keybind(mods.CS, "s", wezterm.action.PaneSelect({ mode = "SwapWithActive" })),
							keybind(mods.CS, "z", wezterm.action.TogglePaneZoomState),
						},
					})
				),
			},
		})
	),
})

config.key_tables.copy_mode = flatten_list({
	wezterm.gui.default_key_tables().copy_mode, -- extend default 'copy_mode' table
	keybind(mods._, "i", wezterm.action.CopyMode("Close")),
})

-- Events related to config reloading
wezterm.on("my-reload-config-with-notif", function(win, pane)
	wezterm.GLOBAL.want_reload_notification = true
	win:perform_action(wezterm.action.ReloadConfiguration, pane)
	-- Will trigger the builtin `window-config-reloaded` event, the notification is wired on
	-- that event, to make sure only a _valid_ config reload will display it.
end)
wezterm.on("window-config-reloaded", function(win, _)
	if wezterm.GLOBAL.want_reload_notification then
		win:toast_notification("wezterm", "Config successfully reloaded!", nil, 1000)
		wezterm.GLOBAL.want_reload_notification = false
	end
end)

-- Make sure word selection stops on most punctuations.
--
-- Note that dot (.) & slash (/) are allowed though for
-- easy selection of (partial) paths.
config.selection_word_boundary = " \t\n{}[]()\"'`,;:@│┃*…$"
config.audible_bell = "Disabled"
config.hide_tab_bar_if_only_one_tab = true

local DOTFILES = os.getenv("USERPROFILE") .. "\\dotfiles"
local PATH = os.getenv("PATH")

config.set_environment_variables = {
	PATH = PATH .. ";" .. DOTFILES .. "\\scripts",
	FZF_CTRL_T_COMMAND = "eza --oneline --absolute --color=always --no-quotes $dir",
	CLINK_PATH = DOTFILES .. "\\scripts",
	CLINK_SETTINGS = DOTFILES,
	CLINK_INPUTRC = DOTFILES,
	STARSHIP_CONFIG = DOTFILES .. "\\starship.toml",
	GIT_CONFIG_GLOBAL = DOTFILES .. "\\git.ini",
	LG_CONFIG_FILE = DOTFILES .. "\\lazygit.yml",
	FZF_DEFAULT_OPTS = "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --color=selected-bg:#45475a --multi",
}

config.default_cursor_style = "SteadyBar"

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "cmd.exe", "/s", "/k", "clink inject -q && " .. DOTFILES .. "\\cmdrc.cmd" }
end

return config
