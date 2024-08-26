--[[

        ███╗░░██╗██╗██╗░░██╗██╗████████╗░█████╗░
        ████╗░██║██║██║░██╔╝██║╚══██╔══╝██╔══██╗
        ██╔██╗██║██║█████═╝░██║░░░██║░░░███████║
        ██║╚████║██║██╔═██╗░██║░░░██║░░░██╔══██║
        ██║░╚███║██║██║░╚██╗██║░░░██║░░░██║░░██║
        ╚═╝░░╚══╝╚═╝╚═╝░░╚═╝╚═╝░░░╚═╝░░░╚═╝░░╚═╝
██████╗░███████╗██╗░░░██╗███████╗███╗░░██╗░█████╗░░█████╗░
██╔══██╗██╔════╝██║░░░██║██╔════╝████╗░██║██╔══██╗██╔══██╗
██████╔╝█████╗░░╚██╗░██╔╝█████╗░░██╔██╗██║██║░░╚═╝██║░░██║
██╔══██╗██╔══╝░░░╚████╔╝░██╔══╝░░██║╚████║██║░░██╗██║░░██║
██║░░██║███████╗░░╚██╔╝░░███████╗██║░╚███║╚█████╔╝╚█████╔╝
╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚══════╝╚═╝░░╚══╝░╚════╝░░╚════╝░
!README !nikitarevenco !nikita !revenco

One file to rule them all.
The perfect Neovim IDE in only a few thousand lines of code.

Plugins (to see the config settings for each plugin, type /!<plugin-name><enter>):
- catppuccin: Color scheme.
- genghis: For renaming files and automatically updating all imports, if the language server supports it
- tabout: Quickly get out of (), "", etc in insert mode
- arrow: Save files to a menu and quickly navigate between them.
- flash: The best plugin ever, its literally like hacks. Lets you do some insane manipulation and travel at superman speeds, a solid replacement for the mouse.
- lazygit: Quality version control. Boosts my productivity with git by like 2x.
- codesnap: Take beatiful pictures of code.
- tailwind-values: See all values that apply to a class with tailwind, as if it was all on a singular css class.
- tailwind-conceal: Hide class names with three dots "..." if the mouse cursor is not hovering on it.
- luasnip: Tons of cool snippets. Check out the docs of friendly-snippets to see the available snippets.
- dap: Debugger.
- neotest: Helps run tests eg for jest.
- dial: Easily change values like const to let and true to false , vise versa etc.
- which-key: See all available shortcuts and text-objects.
- spider: better w, e & b movements.
- dashboard: easily accessible commands upon entering vim in a directory
- nvterm: toggle floating, right or bottom terminal.
- devdocs: documentation for languages or technologies right inside neovim. No need for mdn!
- toggle-checkbox: Switch between [ ] and [x] in markdown.
- todo-comments: highlights comments with special prefixes in them, like todo, warn, bug etc. (in all caps)
- schemastore: autocompletion for various json and yaml files, for example your .eslintrc
- substitute: a new operator that you can use to replace nodes instantly. For examble, siw will take your clipboard, and overwrite the word with it.
(if you find out how to get which-key to show textobjects for it let me know!)
- surround: surround selection with anything. And delete/change too. Like try the following: ds", cs"(, viwS(
- comment: allows you to easily comment line, textobjects etc.
- indent-blankline: shows indent guides
- lsp-lines: better diagnostics. actually shows the character. Each diagnostic is on a separate line too.
- regexplainer: regex can be hard to read. explains what regex does.
- goto-preview: peek preview in a floating lsp window.
- telescope: a lot of stuff. see telescope-keys
- auto-session: when you leave neovim, it saves your session exactly how you left it.
- rainbow-delimiters: colorizer brackets to make them easier to read

Important keymaps:
- leader ni: format file
- leader tr: Toggle Line Diagnostics
- leader ei: File Browser.
- leader rn: Open LazyGit
- leader hjkl: focus window up/down/left/right

Contributing:
- pull requests are welcome.

░█████╗░██████╗░████████╗██╗░█████╗░███╗░░██╗░██████╗
██╔══██╗██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝
██║░░██║██████╔╝░░░██║░░░██║██║░░██║██╔██╗██║╚█████╗░
██║░░██║██╔═══╝░░░░██║░░░██║██║░░██║██║╚████║░╚═══██╗
╚█████╔╝██║░░░░░░░░██║░░░██║╚█████╔╝██║░╚███║██████╔╝
░╚════╝░╚═╝░░░░░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

!options




--]]
vim.cmd("let g:netrw_liststyle = 3")

-- <leader> is space
vim.g.mapleader = " "

-- vim.filetype.add({
-- 	extension = {
-- 		mdx = "mdx",
-- 	},
-- })

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- testing
vim.o.updatetime = 750

-- disable tabline
vim.opt.showtabline = 0

-- line numbers are relative instead of absolute
vim.opt.relativenumber = true

-- show actual line number at the current cursor line instead of 0
vim.opt.number = true

-- 2 spaces for tabs
vim.opt.tabstop = 2

-- 2 spaces for indent width
vim.opt.shiftwidth = 2

-- expand tab to spaces
vim.opt.expandtab = true

-- copy indent from current line when starting a new one
vim.opt.autoindent = true

-- there will always be at least 8 lines visible above and below when moving vertically
vim.opt.scrolloff = 8

-- there will always be at least 8 characters left and right when moving horizontally
vim.opt.sidescrolloff = 8

if vim.fn.has("nvim-0.10") == 1 then
	-- if a line wraps into multiple lines, it will scroll 1 wrapped line at a time instead of 1 full line
	vim.opt.smoothscroll = true
end

-- will conceal everything important. Setting to 3 will not have noticable difference aside from breaking some things so I don't recommend it
vim.opt.conceallevel = 2

-- enable line wrap
vim.opt.wrap = true

-- ignore case when searching
vim.opt.ignorecase = true

-- if you include mixed case in your search assumes you want case-sensitive
vim.opt.smartcase = true

-- highlight the current line we are on
vim.opt.cursorline = true

-- disable the mouse
vim.opt.mouse = ""

-- enable true color support, which allows for all 16 million colours instead of just 256
vim.opt.termguicolors = true

-- colorschemes that can be light or dark will be made dark
vim.opt.background = "dark"

-- show sign column for things like diagnostic signs " "
vim.opt.signcolumn = "yes"

-- allow backspace on indent, end of line or insert mode start position
vim.opt.backspace = "indent,eol,start"

-- use system clipboard as default register
vim.opt.clipboard:append("unnamedplus")

-- split vertical window to the right
vim.opt.splitright = true

-- split horizontal window to the bottom
vim.opt.splitbelow = true

-- turn off swapfile
vim.opt.swapfile = false

-- ██╗░░██╗███████╗██╗░░░██╗███╗░░░███╗░█████╗░██████╗░░██████╗
-- ██║░██╔╝██╔════╝╚██╗░██╔╝████╗░████║██╔══██╗██╔══██╗██╔════╝
-- █████═╝░█████╗░░░╚████╔╝░██╔████╔██║███████║██████╔╝╚█████╗░
-- ██╔═██╗░██╔══╝░░░░╚██╔╝░░██║╚██╔╝██║██╔══██║██╔═══╝░░╚═══██╗
-- ██║░╚██╗███████╗░░░██║░░░██║░╚═╝░██║██║░░██║██║░░░░░██████╔╝
-- ╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═════╝░
-- !keymaps !mappings !keys !keybinds !keybindings

local function urlencode(str)
	return (str:gsub("([^%w])", function(c)
		return string.format("%%%02X", string.byte(c))
	end):gsub(" ", "+"))
end

local function google_search(query)
	local encoded_query = urlencode(query)
	local url = "https://www.google.com/search?q=" .. encoded_query
	vim.fn.system("google-chrome-stable " .. vim.fn.shellescape(url))
end

vim.api.nvim_create_user_command("GoogleSearch", function(opts)
	google_search(opts.args)
end, { nargs = "*" })

-- Normal mode mapping to open :GoogleSearch
vim.api.nvim_set_keymap("n", "<leader><cr>", [[:GoogleSearch ]], { noremap = true, silent = true })
--
-- !icons
local icons = {
	lsp = { Error = " ", Warn = " ", Hint = " ", Info = " " },
	lualine_lsp = { error = " ", warn = " ", hint = " ", info = " " },
	which_key = {
		breadcrumb = "➜", --» symbol used in the command line area that shows your active key combo
		separator = "...", --➜ symbol used between a key and it's label
		group = "", -- symbol prepended to a group
	},
	mason = {
		package_installed = "✓",
		package_pending = "➜",
		package_uninstalled = "✗",
	},
	keymaps = {
		operator = "",
		diagnostic = "",
		bug = "",
		test = "",
		docs = "",
		git = "",
		warn = "",
		action = "",
		window = "",
		file = "",
		open = "",
		info = "",
		terminal = "",
		lightning = "",
		search = "",
		explorer = "",
	},
}

local keymaps = {
	-- TODO: Add "macros" section
	-- some potential brainstorming

	-- adding a comma at the end of the line
	-- ...

	-- () global
	window_focus_left = "<leader>h",
	window_focus_right = "<leader>l",
	window_focus_above = "<leader>k",
	window_focus_below = "<leader>j",

	-- (a) terminal
	terminal_toggle_floating = "<leader>ae",
	terminal_toggle_horizontal = "<leader>at",
	terminal_toggle_vertical = "<leader>an",

	-- (r) git
	git_blame_toggle = "<leader>rn",
	lazygit_project = "<leader>re",
	lazygit_file = "<leader>rt",
	lazygit_commits_project = "<leader>rs",
	lazygit_commits_file = "<leader>ri",

	-- (s) window
	window_quit = "<leader>so",
	window_slide = "<leader>sa",
	window_close = "<leader>ss",
	window_equalize = "<leader>se",
	window_maximize_vertically = "<leader>su",
	window_maximize_horizontally = "<leader>sy",
	window_maximize = "<leader>sn",
	window_split_vertically = "<leader>sm",
	window_split_horizontally = "<leader>sg",
	restore_session = "<leader>sr",

	-- (t) info
	info_toggle_conceal = "<leader>tr",
	lsp_hover = "<leader>tt",
	message_history = "<leader>tn",
	undo_history = "<leader>ti",
	headings = "<leader>to",
	tailwind_show_values = "<leader>ts",
	todos = "<leader>te",

	-- (n) code action
	lsp_code_actions = "<leader>na",
	lsp_rename = "<leader>nr",
	dial_increment = "<leader>ns",
	ts_remove_unused_imports = "<leader>nn",
	ts_add_missing_imports = "<leader>np",
	code_action_move_line_up = "<leader>nk",
	code_action_move_line_down = "<leader>nj",
	import = "<leader>ne",
	icon = "<leader>nl",
	organize_imports = "<leader>nm",
	remove_unused = "<leader>nz",

	-- (e) explorer
	buffers = "<leader>ea",
	media_files = "<leader>en",
	recent_files = "<leader>ee",
	find_files = "<leader>ei",
	explorer_cwd = "<leader>eo",
	explorer_project = "<leader>et",
	explorer_ideas = "<leader>es",
	explorer_projects = "<leader>er",

	-- (i) find
	symbols_project = "<leader>ia",
	symbols_file = "<leader>ir",
	type_definitions = "<leader>is",
	implementations = "<leader>it",
	grep_cwd = "<leader>in",
	grep_file = "<leader>ie",
	grep_string = "<leader>ii",
	incoming_calls = "<leader>io",
	outgoing_calls = "<leader>im",
	references = "<leader>ig",
	definitions = "<leader>iu",
	ts_file_references = "<leader>ip",

	-- (o) goto
	lsp_goto_definition = "<leader>oq",
	lsp_ts_goto_definition = "<leader>oa",
	lsp_goto_type_definition = "<leader>or",
	lsp_goto_implementation = "<leader>os",
	lsp_restart = "<leader>oz",
	lsp_goto_declaration = "<leader>ot",
	open_todo = "<leader>on",
	open_nvim_config = "<leader>oe",
	lazy_open = "<leader>oi",
	open_dashboard = "<leader>oo",

	-- (w) diagnostic
	telescope_diagnostics = "<leader>wn",
	quickfixes = "<leader>wt",
	toggle_diagnostic_lines = "<leader>we",

	-- (m) debug
	toggle_breakpoint = "<leader>mn",
	run_debugger = "<leader>ma",
	terminate_debugger = "<leader>mt",
	run_last_debugger = "<leader>mo",

	-- (g) test
	test_file = "<leader>gt",
	test_project = "<leader>gn",
	run_nearest_test = "<leader>gr",
	run_last_test = "<leader>ge",
	toggle_test_summary = "<leader>gi",
	show_test_output = "<leader>go",
	toggle_test_output = "<leader>ga",
	stop_testing = "<leader>gs",
	debug_nearest_test = "<leader>gg",

	-- (f) docs
	devdocs_open = "<leader>fn",
	devdocs_open_file = "<leader>ft",
	devdocs_toggle = "<leader>fe",
	devdocs_fetch = "<leader>f<leader>a",
	devdocs_update_all = "<leader>f<leader>r",
	devdocs_install = "<leader>f<leader>s",
	devdocs_uninstall = "<leader>f<leader>t",

	-- (u) file
	rename_file = "<leader>ua",
	ts_rename_file = "<leader>uu",
	move_file = "<leader>ur",
	move_file_to_folder = "<leader>us",
	trash_file = "<leader>ut",
	copy_file_path = "<leader>un",
	copy_folder_path = "<leader>ue",
	copy_file_name = "<leader>ui",
	chmodx = "<leader>uo",

	-- other
	cmp_abort = "<C-e>",
	cmp_confirm = "<CR>",
	code_action_delete_word = "<C-BS>",
	code_action_write_file = "<cr>",
	tailwind_copy_full_tailwind_values = "<C-y>",
	movement_page_down = "J",
	movement_page_up = "K",
	jump = "<left>",
	window_close_some_file_types = "q",
	window_decrease_width = "<C-Left>",
	window_increase_width = "<C-Right>",
	window_decrease_height = "<C-Down>",
	window_increase_height = "<C-Up>",
	window_previous_file = "<bs>",
	signature_help = "<c-s>",
	select_around_node = "<up>",
	search_select_node = "<right>",
	arrow_leader = "<CR>",
	terminal_exit_terminal_mode = "<esc>",
	arrow = {
		next_item = "<right>",
		prev_item = "<left>",
		edit = "y",
		toggle = "<space>",
		delete_mode = "g",
		open_vertical = "f",
		open_horizontal = "u",
		remove = "l",
		clear_all_items = ".",
	},
	code_screenshot = "<leader>e",
	code_screenshot_save = "<leader>n",
	info_screenkey_toggle = "<leader>zj",
	execute_normal_command = "<C-s>",
}
-- respect wrapped lines when moving up or down
vim.keymap.set(
	{ "n", "x" },
	"j",
	"v:count == 0 ? 'gj' : 'j'",
	{ desc = "which_key_ignore", expr = true, silent = true }
)

vim.keymap.set(
	{ "n", "x" },
	"k",
	"v:count == 0 ? 'gk' : 'k'",
	{ desc = "which_key_ignore", expr = true, silent = true }
)

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Enable inlay hints",
	callback = function(event)
		local id = vim.tbl_get(event, "data", "client_id")
		local client = id and vim.lsp.get_client_by_id(id)
		if client == nil or not client.supports_method("textDocument/inlayHint") then
			return
		end

		vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
	end,
})

-- better page up/down
vim.keymap.set(
	{ "n" },
	keymaps.movement_page_down,
	"<C-d>",
	{ desc = icons.keymaps.lightning .. "page down", noremap = true, silent = true }
)

-- better page up/down
vim.keymap.set({ "i" }, keymaps.execute_normal_command, "<C-o>")

vim.keymap.set(
	{ "n" },
	keymaps.movement_page_up,
	"<C-u>",
	{ desc = icons.keymaps.lightning .. "page up", noremap = true, silent = true }
)

-- Resize window using <ctrl> arrow keys
vim.keymap.set(
	"n",
	keymaps.window_increase_height,
	"<cmd>resize +2<cr>",
	{ desc = icons.keymaps.window .. "increase buffer height" }
)
vim.keymap.set(
	"n",
	keymaps.window_decrease_height,
	"<cmd>resize -2<cr>",
	{ desc = icons.keymaps.window .. "decrease buffer height" }
)
vim.keymap.set(
	"n",
	keymaps.window_increase_width,
	"<cmd>vertical resize -2<cr>",
	{ desc = icons.keymaps.window .. "increase buffer width" }
)
vim.keymap.set(
	"n",
	keymaps.window_decrease_width,
	"<cmd>vertical resize +2<cr>",
	{ desc = icons.keymaps.window .. "decrease buffer width" }
)

-- I have no idea what this does in vanilla
-- vim.keymap.set("n", "<C-Space>", "<nop>", { desc = "which_key_ignore" })
--
-- Move Lines
vim.keymap.set(
	"n",
	keymaps.code_action_move_line_down,
	"<cmd>m .+1<cr>==",
	{ desc = icons.keymaps.action .. "move line down" }
)
vim.keymap.set(
	"n",
	keymaps.code_action_move_line_up,
	"<cmd>m .-2<cr>==",
	{ desc = icons.keymaps.action .. "move line up" }
)
vim.keymap.set(
	"v",
	keymaps.code_action_move_line_down,
	":m '>+1<cr>gv=gv",
	{ desc = icons.keymaps.action .. "move line down" }
)
vim.keymap.set(
	"v",
	keymaps.code_action_move_line_up,
	":m '<-2<cr>gv=gv",
	{ desc = icons.keymaps.action .. "move line up" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "which_key_ignore" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "which_key_ignore" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "which_key_ignore" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "which_key_ignore" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "which_key_ignore" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "which_key_ignore" })

-- window management
vim.keymap.set(
	"n",
	keymaps.window_split_horizontally,
	"<C-w>v",
	{ desc = icons.keymaps.window .. "split window horizontally" }
)
vim.keymap.set(
	"n",
	keymaps.window_split_vertically,
	"<C-w>s",
	{ desc = icons.keymaps.window .. "split window vertically" }
)
vim.keymap.set("n", keymaps.window_maximize, "<C-w>_<C-w>|", { desc = icons.keymaps.window .. "Maximize Windows" })
vim.keymap.set(
	"n",
	keymaps.window_maximize_horizontally,
	"<C-w>|",
	{ desc = icons.keymaps.window .. "maximize horizontally" }
)
vim.keymap.set(
	"n",
	keymaps.window_maximize_vertically,
	"<C-w>_",
	{ desc = icons.keymaps.window .. "maximize vertically" }
)
vim.keymap.set("n", keymaps.window_equalize, "<C-w>=", { desc = icons.keymaps.window .. "equalize windows" })
vim.keymap.set("n", keymaps.window_close, "<cmd>close<CR>", { desc = icons.keymaps.window .. "close window" })
vim.keymap.set("n", keymaps.window_slide, "<C-w>R", { desc = icons.keymaps.window .. "slide windows" })
vim.keymap.set("n", keymaps.window_quit, "<cmd>qa!<cr>", { desc = icons.keymaps.window .. "quit neovim" })
vim.keymap.set(
	{ "n" },
	keymaps.window_previous_file,
	"<cmd>edit #<cr>",
	{ desc = icons.keymaps.window .. "previous window", silent = true }
)

-- Move to window using the <leader> hjkl keys
vim.keymap.set(
	"n",
	keymaps.window_focus_left,
	"<C-w>h",
	{ desc = icons.keymaps.window .. "focus buffer left", remap = true }
)
vim.keymap.set(
	"n",
	keymaps.window_focus_below,
	"<C-w>j",
	{ desc = icons.keymaps.window .. "focus buffer below", remap = true }
)
vim.keymap.set(
	"n",
	keymaps.window_focus_above,
	"<C-w>k",
	{ desc = icons.keymaps.window .. "focus buffer above", remap = true }
)
vim.keymap.set(
	"n",
	keymaps.window_focus_right,
	"<C-w>l",
	{ desc = icons.keymaps.window .. "focus buffer right", remap = true }
)

-- Open lazy.nvim plugin manager
vim.keymap.set("n", keymaps.lazy_open, "<cmd>Lazy<cr>", { desc = icons.keymaps.open .. "lazy" })

-- toggle conceal
vim.keymap.set("n", keymaps.info_toggle_conceal, function()
	if vim.wo.conceallevel == 2 then
		vim.opt.conceallevel = 0
	else
		vim.opt.conceallevel = 2
	end
end, { desc = icons.keymaps.info .. "toggle conceal" })

-- show information for what is under the cursor
vim.keymap.set("n", keymaps.lsp_hover, vim.lsp.buf.hover, { desc = icons.keymaps.info .. "hover" })

-- Ctrl-Backspace deletes word
vim.api.nvim_set_keymap(
	"i",
	keymaps.code_action_delete_word,
	"<esc>caw",
	{ noremap = true, desc = icons.keymaps.action .. "delete word" }
)

-- write file which triggers various formatters
vim.keymap.set("n", keymaps.code_action_write_file, "<cmd>w<cr><esc>", { desc = icons.keymaps.action .. "format" })

-- Go back into normal mode in terminal, but not in lazygit
vim.keymap.set("t", keymaps.terminal_exit_terminal_mode, function()
	if string.find(vim.api.nvim_buf_get_name(0), "lazygit") then
		-- lazygit breaks if we exit terminal mode, it has custom keybinds for <esc> too.
		return "<esc>"
	else
		return "<C-\\><C-n>"
	end
end, {
	expr = true,
	noremap = true,
	silent = true,
	desc = icons.keymaps.terminal .. "leave terminal mode",
})

-- Organize imports
-- vim.keymap.set("n", keymaps.organize_imports, function()
-- 	vim.lsp.buf.execute_command({
-- 		command = "_typescript.organizeImports",
-- 		arguments = { vim.api.nvim_buf_get_name(0) },
-- 	})
-- end, { desc = icons.keymaps.action .. "organize imports" })

-- Organize imports
vim.keymap.set("i", keymaps.signature_help, function()
	vim.lsp.buf.signature_help()
end, { desc = icons.keymaps.action .. "" })

-- Access some files easily
vim.keymap.set("n", keymaps.open_todo, "<cmd>e ~/thoughts-ideas/todo.md<cr>", { desc = icons.keymaps.open .. "todo" })
vim.keymap.set(
	"n",
	keymaps.open_nvim_config,
	"<cmd>e ~/dotfiles/nvim/init.lua<cr>",
	{ desc = icons.keymaps.open .. "neovim config" }
)

-- ░█████╗░██╗░░░██╗████████╗░█████╗░░█████╗░███╗░░░███╗██████╗░░██████╗
-- ██╔══██╗██║░░░██║╚══██╔══╝██╔══██╗██╔══██╗████╗░████║██╔══██╗██╔════╝
-- ███████║██║░░░██║░░░██║░░░██║░░██║██║░░╚═╝██╔████╔██║██║░░██║╚█████╗░
-- ██╔══██║██║░░░██║░░░██║░░░██║░░██║██║░░██╗██║╚██╔╝██║██║░░██║░╚═══██╗
-- ██║░░██║╚██████╔╝░░░██║░░░╚█████╔╝╚█████╔╝██║░╚═╝░██║██████╔╝██████╔╝
-- ╚═╝░░╚═╝░╚═════╝░░░░╚═╝░░░░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚═════╝░╚═════╝░
-- !autocommands !autocmds !auto

-- autosave
vim.api.nvim_create_autocmd(
	{ "FocusLost", "ModeChanged", "TextChanged", "BufEnter" },
	{ pattern = "*", command = "silent! update" }
)

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- vim.api.nvim_create_autocmd("InsertEnter", {
-- 	callback = function()
-- 		vim.diagnostic.hide()
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("ModeChanged", {
-- 	pattern = "i:*",
-- 	callback = function()
-- 		vim.diagnostic.show()
-- 	end,
-- })

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- check for spell in text filetypes
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "gitcommit", "markdown" },
-- 	callback = function()
-- 		vim.opt_local.spell = true
-- 	end,
-- })

-- auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- close some file types with q
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", keymaps.window_close_some_file_types, "<cmd>close<cr>", {
			desc = icons.keymaps.window .. "close",
			buffer = event.buf,
			silent = true,
		})
	end,
})

-- ██████╗░██╗░░░░░██╗░░░██╗░██████╗░██╗███╗░░██╗░██████╗
-- ██╔══██╗██║░░░░░██║░░░██║██╔════╝░██║████╗░██║██╔════╝
-- ██████╔╝██║░░░░░██║░░░██║██║░░██╗░██║██╔██╗██║╚█████╗░
-- ██╔═══╝░██║░░░░░██║░░░██║██║░░╚██╗██║██║╚████║░╚═══██╗
-- ██║░░░░░███████╗╚██████╔╝╚██████╔╝██║██║░╚███║██████╔╝
-- ╚═╝░░░░░╚══════╝░╚═════╝░░╚═════╝░╚═╝╚═╝░░╚══╝╚═════╝░
-- !plugins

local plugins = {

	-- ░█████╗░░█████╗░██████╗░███████╗
	-- ██╔══██╗██╔══██╗██╔══██╗██╔════╝
	-- ██║░░╚═╝██║░░██║██████╔╝█████╗░░
	-- ██║░░██╗██║░░██║██╔══██╗██╔══╝░░
	-- ╚█████╔╝╚█████╔╝██║░░██║███████╗
	-- ░╚════╝░░╚════╝░╚═╝░░╚═╝╚══════╝
	-- !core
	{
		-- !tw-values
		"MaximilianLloyd/tw-values.nvim",
		cond = false,
		keys = {
			{
				keymaps.tailwind_show_values,
				"<cmd>TWValues<cr>",
				desc = icons.keymaps.info .. "tailwind values",
			},
		},
		ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
		opts = {
			border = "rounded",
			show_unknown_classes = true,
			focus_preview = true,
			copy_register = "",
			keymaps = {
				copy = keymaps.tailwind_copy_full_tailwind_values,
			},
		},
	},
	{
		-- !tailwind-fold
		"razak17/tailwind-fold.nvim",
		cond = false,
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
	},
	-- NOTE: this plugin is causing some issues
	{
		-- Tailwind classes are sorted automatically on save
		-- !tailwind-sorter !tailwind !core
		"laytan/tailwind-sorter.nvim",
		cond = false,
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		build = "cd formatter && npm ci && npm run build",
		ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
		config = true,
		opts = {
			on_save_enabled = true,
		},
	},
	{
		"windwp/nvim-ts-autotag",
		commit = "323a3e16ed603e2e17b26b1c836d1e86c279f726",
		cond = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false, -- Auto close on trailing </
				},
			})
		end,
	},
	{
		"davidmh/mdx.nvim",
		config = true,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		-- !treesitter
		"nvim-treesitter/nvim-treesitter",
		cond = true,
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "TSInstall", "TSUpdate", "TSUpdateSync" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
				},
				indent = { enable = true },
				-- autotag = {
				-- 	enable = true,
				-- },
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"tsx",
					"yaml",
					"html",
					"bash",
					"css",
					"prisma",
					"csv",
					"gitcommit",
					"gitignore",
					"markdown",
					"markdown_inline",
					"regex",
					"scss",
					"svelte",
					"graphql",
					"bash",
					"lua",
					"tmux",
					"toml",
					"vim",
					"dockerfile",
					"gitignore",
					"query",
					"vimdoc",
					"c",
				},
			})
		end,
	},
	{
		-- !treesitter-textobjects
		"nvim-treesitter/nvim-treesitter-textobjects",
		cond = true,
		event = { "BufWritePre", "BufReadPre" },
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							["ah"] = { query = "@assignment.outer", desc = "lol" },
							["ih"] = { query = "@assignment.inner", desc = "assignment" },

							["as"] = { query = "@assignment.lhs", desc = "LHS assignment" },
							["is"] = { query = "@assignment.rhs", desc = "RHS assignment" },

							["ai"] = { query = "@conditional.outer", desc = "conditional" },
							["ii"] = { query = "@conditional.inner", desc = "conditional" },

							["al"] = { query = "@loop.outer", desc = "loop" },
							["il"] = { query = "@loop.inner", desc = "loop" },

							["af"] = { query = "@call.outer", desc = "function call" },
							["if"] = { query = "@call.inner", desc = "function call" },

							["aa"] = { query = "@parameter.outer", desc = "argument" },
							["ia"] = { query = "@parameter.inner", desc = "argument" },

							["am"] = { query = "@function.outer", desc = "function" },
							["im"] = { query = "@function.inner", desc = "function" },
						},
					},
					-- swap = {
					-- 	-- Does not work
					-- 	enable = true,
					-- 	swap_next = {
					-- 		-- ["[a"] = { "@parameter.inner", desc = "swap argument" }, -- swap parameters/argument with next
					-- 		-- ["[r"] = { "@property.outer", desc = "swap property" }, -- swap object property with next
					-- 		-- ["[s"] = { "@function.outer", desc = "swap function" }, -- swap function with next
					-- 	},
					-- 	swap_previous = {
					-- 		-- ["]a"] = { "@parameter.inner", desc = "swap argument" }, -- swap parameters/argument with prev
					-- 		-- ["]r"] = { "@property.outer", desc = "swap property" }, -- swap object property with prev
					-- 		-- ["]s"] = { "@function.outer", desc = "swap function" }, -- swap function with previous
					-- 	},
					-- },
					-- move = {
					-- 	enable = false,
					-- 	set_jumps = true, -- whether to set jumps in the jumplist
					-- 	goto_next_start = {
					-- 		["]f"] = { query = "@call.outer", desc = "function call start" },
					-- 		["]m"] = { query = "@function.outer", desc = "function start" },
					-- 		["]c"] = { query = "@class.outer", desc = "class start" },
					-- 		["]i"] = { query = "@conditional.outer", desc = "conditional start" },
					-- 		-- ["]l"] = { query = "@loop.outer", desc = "loop start" },
					--
					-- 		-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
					-- 		-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
					-- 		-- ["]s"] = { query = "@scope", query_group = "locals", desc = "scope" },
					-- 	},
					-- 	goto_next_end = {
					-- 		["]F"] = { query = "@call.outer", desc = "function call end" },
					-- 		["]M"] = { query = "@function.outer", desc = "function end" },
					-- 		["]C"] = { query = "@class.outer", desc = "class end" },
					-- 		["]I"] = { query = "@conditional.outer", desc = "conditional end" },
					-- 		-- ["]L"] = { query = "@loop.outer", desc = "loop end" },
					-- 	},
					-- 	goto_previous_start = {
					-- 		["[f"] = { query = "@call.outer", desc = "function call start" },
					-- 		["[m"] = { query = "@function.outer", desc = "function start" },
					-- 		["[c"] = { query = "@class.outer", desc = "class start" },
					-- 		["[i"] = { query = "@conditional.outer", desc = "conditional start" },
					-- 		-- ["[l"] = { query = "@loop.outer", desc = "loop start" },
					-- 	},
					-- 	goto_previous_end = {
					-- 		["[F"] = { query = "@call.outer", desc = "function call end" },
					-- 		["[M"] = { query = "@function.outer", desc = "function end" },
					-- 		["[C"] = { query = "@class.outer", desc = "class end" },
					-- 		["[I"] = { query = "@conditional.outer", desc = "conditional end" },
					-- 		-- ["[L"] = { query = "@loop.outer", desc = "loop end" },
					-- 	},
					-- },
				},
			})

			-- local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

			-- vim way: ; goes to the direction you were moving.
			-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
			-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
		end,
	},
	{
		-- !various-textobjs
		"chrisgrieser/nvim-various-textobjs",
		cond = true,
		-- lazy = true,
		event = { "BufReadPre", "BufWritePre" },
		config = function()
			require("various-textobjs").setup({
				useDefaultKeymaps = false,
			})
			vim.keymap.set("n", "gx", function()
				require("various-textobjs").url()
				local foundURL = vim.fn.mode():find("v")
				if foundURL then
					vim.cmd.normal('"zy')
					local url = vim.fn.getreg("z")
					vim.ui.open(url)
				else
					-- find all URLs in buffer
					local urlPattern = require("various-textobjs.charwise-textobjs").urlPattern
					local bufText = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
					local urls = {}
					for url in bufText:gmatch(urlPattern) do
						table.insert(urls, url)
					end
					if #urls == 0 then
						return
					end

					-- select one, use a plugin like dressing.nvim for nicer UI for
					-- `vim.ui.select`
					vim.ui.select(urls, { prompt = "Select URL:" }, function(choice)
						if choice then
							vim.ui.open(choice)
						end
					end)
				end
			end, { desc = "open url" })

			-- Subword: Treats -, _ and . as word delimiters and only part of camelCase
			vim.keymap.set({ "o", "x" }, "ir", function()
				require("various-textobjs").subword("inner")
			end, { desc = "subword" })

			vim.keymap.set({ "o", "x" }, "ar", function()
				require("various-textobjs").subword("outer")
			end, { desc = "subword" })

			vim.keymap.set({ "o", "x" }, "(", function()
				require("various-textobjs").toNextClosingBracket()
			end, { desc = "to next bracket" })

			vim.keymap.set({ "o", "x" }, '"', function()
				require("various-textobjs").toNextQuotationMark()
			end, { desc = "to next quotation mark" })

			vim.keymap.set({ "o", "x" }, "A", function()
				require("various-textobjs").entireBuffer()
			end, { desc = "buffer" })

			vim.keymap.set({ "o", "x" }, "o", function()
				require("various-textobjs").nearEoL()
			end, { desc = "near end of line" })

			vim.keymap.set({ "o", "x" }, "n", function()
				require("various-textobjs").lineCharacterwise("inner")
			end, { desc = "line characterwise" })

			vim.keymap.set({ "o", "x" }, "ij", function()
				require("various-textobjs").mdEmphasis("inner")
			end, { desc = "markdown emphasis" })
			vim.keymap.set({ "o", "x" }, "aj", function()
				require("various-textobjs").mdEmphasis("outer")
			end, { desc = "markdown emphasis" })

			vim.keymap.set({ "o", "x" }, "ij", function()
				require("various-textobjs").mdFencedCodeBlock("inner")
			end, { desc = "markdown code" })
			vim.keymap.set({ "o", "x" }, "aj", function()
				require("various-textobjs").mdFencedCodeBlock("outer")
			end, { desc = "markdown code" })

			vim.keymap.set({ "o", "x" }, "in", function()
				require("various-textobjs").htmlAttribute("inner")
			end, { desc = "tag attribute" })
			vim.keymap.set({ "o", "x" }, "an", function()
				require("various-textobjs").htmlAttribute("outer")
			end, { desc = "tag attribute" })

			vim.keymap.set({ "o", "x" }, "io", function()
				require("various-textobjs").value("inner")
			end, { desc = "value" })
			vim.keymap.set({ "o", "x" }, "ao", function()
				require("various-textobjs").value("outer")
			end, { desc = "value" })

			vim.keymap.set({ "o", "x" }, "ie", function()
				require("various-textobjs").key("inner")
			end, { desc = "key" })
			vim.keymap.set({ "o", "x" }, "ae", function()
				require("various-textobjs").key("outer")
			end, { desc = "key" })

			vim.keymap.set({ "o", "x" }, "u", function()
				require("various-textobjs").url()
			end, { desc = "url" })

			vim.keymap.set({ "o", "x" }, "ig", function()
				require("various-textobjs").chainMember("inner")
			end, { desc = "chain" })
			vim.keymap.set({ "o", "x" }, "ag", function()
				require("various-textobjs").chainMember("outer")
			end, { desc = "chain" })
		end,
	},
	{
		-- !cmp
		"hrsh7th/nvim-cmp",
		cond = true,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			{
				"L3MON4D3/LuaSnip",
				-- follow latest release.
				version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
				-- install jsregexp (optional!).
				build = "make install_jsregexp",
				opts = { updateevents = "TextChanged,TextChangedI" },
				keys = {},
			},
			"saadparwaiz1/cmp_luasnip", -- for autocompletion
			"rafamadriz/friendly-snippets", -- useful snippets
			"onsails/lspkind.nvim", -- vs-code like pictograms
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		config = function()
			local cmp = require("cmp")

			-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
			require("luasnip.loaders.from_vscode").lazy_load()

			-- local capabilities =
			-- 	require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
			--
			-- capabilities.textDocument.completion.completionItem.snippetSupport = false

			cmp.setup({
				performance = {
					max_view_entries = 3,
				},
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				-- snippet = { -- configure how nvim-cmp interacts with snippet engine
				-- 	expand = function(args)
				-- 		require("luasnip").lsp_expand(args.body)
				-- 	end,
				-- },

				mapping = cmp.mapping.preset.insert({
					-- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
					-- ["<C-f>"] = cmp.mapping.scroll_docs(4),
					[keymaps.cmp_abort] = cmp.mapping.abort(),
					[keymaps.cmp_confirm] = cmp.mapping.confirm({ select = true }),
				}),

				-- sources for autocompletion
				sources = cmp.config.sources({
					-- NOTE: This is the one that is causing those <tag></tag> completions
					{
						name = "nvim_lsp",
						entry_filter = function(entry, ctx)
							return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
						end,
					},
					{ name = "luasnip" }, -- snippets
					{ name = "buffer" }, -- text within current buffer
					{ name = "path" }, -- file system paths
				}),

				-- configure lspkind for vs-code like pictograms in completion menu
				formatting = {
					format = function(entry, item)
						-- Apply the original lspkind formatting
						item = require("lspkind").cmp_format({
							maxwidth = 50, -- specifies the maximum width of the text part
							ellipsis_char = "...", -- specifies the characters added when the text part is truncated
						})(entry, item)

						-- Then apply the Tailwind CSS colorizer formatting
						return require("tailwindcss-colorizer-cmp").formatter(entry, item)
					end,
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},

		config = function()
			require("mason").setup({
				ui = {
					icons = icons.mason,
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					-- "tsserver",
					"astro",
					"html",
					"cssls",
					"tailwindcss",
					"bashls",
					"mdx_analyzer",
					"svelte",
					"lua_ls",
					"graphql",
					"emmet_ls",
					"prismals",
					"pyright",
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettierd",
					"stylua",
					"isort",
					"shfmt",
					"black",
					"pylint",
					"eslint_d",
					"js-debug-adapter",
				},
			})
		end,
	},
	{
		"OXY2DEV/helpview.nvim",
		lazy = false, -- Recommended

		-- In case you still want to lazy load
		ft = "help",

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	-- {
	-- 	"OXY2DEV/markview.nvim",
	-- 	ft = "markdown",
	--
	-- 	dependencies = {
	-- 		-- You may not need this if you don't lazy load
	-- 		-- Or if the parsers are in your $RUNTIMEPATH
	-- 		"nvim-treesitter/nvim-treesitter",
	--
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- },
	--
	--
	--
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				keymaps.explorer_cwd,
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				keymaps.explorer_project,
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				-- NOTE: this requires a version of yazi that includes
				-- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = true,

			-- enable these if you are using the latest version of yazi
			-- use_ya_for_events_reading = true,
			-- use_yazi_client_id_flag = true,

			keymaps = {
				show_help = "<f1>",
			},
		},
	},
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- required by telescope
			"MunifTanjim/nui.nvim",

			-- optional
			"nvim-treesitter/nvim-treesitter",
			"rcarriga/nvim-notify",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			lang = "typescript",
		},
	},
	{
		-- !lspconfig
		"neovim/nvim-lspconfig",
		cond = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/neodev.nvim", opts = {} },
			-- Autocompletion for files like .eslintrc
			-- { "b0o/schemastore.nvim" },
		},
		opts = {
			diagnostics = {
				underline = false,
			},
		},
		config = function()
			local lspconfig = require("lspconfig")

			local function filter_diagnostics(diagnostics)
				local new_diagnostics = {}
				for _, diagnostic in ipairs(diagnostics) do
					if diagnostic.code ~= 6133 and diagnostic.code ~= 6196 then
						table.insert(new_diagnostics, diagnostic)
					end
				end
				return new_diagnostics
			end

			vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
				result.diagnostics = filter_diagnostics(result.diagnostics)
				vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
			end

			-- lspconfig.jsonls.setup({
			-- 	settings = {
			-- 		json = {
			-- 			schemas = require("schemastore").json.schemas(),
			-- 			validate = { enable = true },
			-- 		},
			-- 	},
			-- })

			-- lspconfig.yamlls.setup({
			--   settings = {
			--     yaml = {
			--       schemaStore = {
			--         enable = false,
			--         url = "",
			--       },
			--       schemas = require("schemastore").yaml.schemas(),
			--     },
			--   },
			-- })

			local mason_lspconfig = require("mason-lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Buffer local mappings.
					local opts = { buffer = ev.buf, silent = true }

					opts.desc = icons.keymaps.action .. "code actions"
					vim.keymap.set({ "n", "v" }, keymaps.lsp_code_actions, vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

					opts.desc = icons.keymaps.action .. "rename"
					vim.keymap.set("n", keymaps.lsp_rename, vim.lsp.buf.rename, opts) -- smart rename

					opts.desc = "go to previous diagnostic"
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
					opts.desc = "go to next diagnostic"
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

					opts.desc = icons.keymaps.open .. "go to definition"
					vim.keymap.set("n", keymaps.lsp_goto_definition, vim.lsp.buf.definition, opts)

					opts.desc = icons.keymaps.open .. "go to type definition"
					vim.keymap.set("n", keymaps.lsp_goto_type_definition, vim.lsp.buf.type_definition, opts)

					opts.desc = icons.keymaps.open .. "restart lsp"
					vim.keymap.set("n", keymaps.lsp_restart, "<cmd>LspRestart<cr>", opts)

					opts.desc = icons.keymaps.open .. "go to implementation"
					vim.keymap.set("n", keymaps.lsp_goto_implementation, vim.lsp.buf.implementation, opts)

					opts.desc = icons.keymaps.open .. "go to declaration"
					vim.keymap.set("n", keymaps.lsp_goto_declaration, vim.lsp.buf.declaration, opts)
				end,
			})

			-- used to enable autocompletion (assign to every lsp server config)
			local capabilities = cmp_nvim_lsp.default_capabilities()

			for type, icon in pairs(icons.lsp) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			mason_lspconfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["mdx_analyzer"] = function()
					lspconfig["mdx_analyzer"].setup({
						filetypes = {
							"mdx",
							"markdown.mdx",
						},
						-- init_options = {
						-- 	typescript = {
						-- 		enabled = true,
						-- 		-- tsdk = "/usr/lib/node_modules/typescript/lib",
						-- 	},
						-- },
						-- root_dir = function(fname)
						-- 	return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
						-- end,
						-- init_options = {
						-- 	typescript = {},
						-- },
						-- on_new_config = function(new_config, new_root_dir)
						-- 	if
						-- 		vim.tbl_get(new_config.init_options, "typescript")
						-- 		and not new_config.init_options.typescript.tsdk
						-- 	then
						-- 		-- LATER: Support custom typescript lib
						-- 		--
						-- 		-- local tsdk = require("util.typescript").get_tsdk_from_config() or get_typescript_server_path(new_root_dir)
						-- 		new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
						-- 	end
						-- end,
					})
				end,
				["tailwindcss"] = function()
					lspconfig["tailwindcss"].setup({
						capabilities = capabilities,
						settings = {
							tailwindCSS = {
								experimental = {
									classRegex = {
										{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
										{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
									},
								},
							},
						},
						-- root_dir = lspconfig.util.root_pattern(
						-- 	"tailwind.config.js",
						-- 	"tailwind.config.cjs",
						-- 	"tailwind.config.ts",
						-- 	"postcss.config.js",
						-- 	"postcss.config.cjs",
						-- 	"postcss.config.ts"
						-- ),
					})
				end,
				["bashls"] = function()
					lspconfig["bashls"].setup({
						capabilities = capabilities,
						filetypes = { "sh", "zsh" },
						settings = {
							bash = {
								format = {
									enable = true,
								},
							},
						},
					})
				end,
				-- ["tsserver"] = function()
				-- 	lspconfig["tsserver"].setup({
				-- 		capabilities = capabilities,
				-- 		completions = {
				-- 			completeFunctionCalls = true,
				-- 		},
				-- 		-- settings = {
				-- 		-- 	javascript = {
				-- 		-- 		inlayHints = {
				-- 		-- 			includeInlayEnumMemberValueHints = true,
				-- 		-- 			includeInlayFunctionLikeReturnTypeHints = true,
				-- 		-- 			includeInlayFunctionParameterTypeHints = true,
				-- 		-- 			includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
				-- 		-- 			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				-- 		-- 			includeInlayPropertyDeclarationTypeHints = true,
				-- 		-- 			includeInlayVariableTypeHints = false,
				-- 		-- 		},
				-- 		-- 	},
				-- 		--
				-- 		-- 	typescript = {
				-- 		-- 		inlayHints = {
				-- 		-- 			includeInlayEnumMemberValueHints = true,
				-- 		-- 			includeInlayFunctionLikeReturnTypeHints = true,
				-- 		-- 			includeInlayFunctionParameterTypeHints = true,
				-- 		-- 			includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
				-- 		-- 			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				-- 		-- 			includeInlayPropertyDeclarationTypeHints = true,
				-- 		-- 			includeInlayVariableTypeHints = false,
				-- 		-- 		},
				-- 		-- 	},
				-- 		-- },
				-- 	})
				-- end,
				["svelte"] = function()
					lspconfig["svelte"].setup({
						capabilities = capabilities,
						on_attach = function(client)
							vim.api.nvim_create_autocmd("BufWritePost", {
								pattern = { "*.js", "*.ts" },
								callback = function(ctx)
									-- Here use ctx.match instead of ctx.file
									client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
								end,
							})
						end,
					})
				end,
				["graphql"] = function()
					lspconfig["graphql"].setup({
						capabilities = capabilities,
						filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
					})
				end,
				["cssls"] = function()
					lspconfig["cssls"].setup({
						capabilities = capabilities,
						settings = {
							css = {
								lint = {
									unknownAtRules = "ignore",
								},
							},
						},
					})
				end,
				["emmet_ls"] = function()
					lspconfig["emmet_ls"].setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"typescriptreact",
							"javascriptreact",
							"css",
							"sass",
							"scss",
							"less",
							"svelte",
						},
					})
				end,
				["lua_ls"] = function()
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					})
				end,
			})
		end,
	},
	{
		-- !lint
		"mfussenegger/nvim-lint",
		cond = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				mdx = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				svelte = { "eslint_d" },
				python = { "pylint" },
			}

			-- This is needed to remove the "no ESLINT config found" error if there does not
			-- exist a .eslintrc file
			-- lint.linters.eslint_d.args = {
			-- 	"eslint_d",
			-- 	"--no-warn-ignored",
			-- 	"--format",
			-- 	"json",
			-- 	"--stdin",
			-- 	"--stdin-filename",
			-- 	function()
			-- 		return vim.api.nvim_buf_get_name(0)
			-- 	end,
			-- }

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
	{
		-- !conform
		"stevearc/conform.nvim",
		lazy = false,
		cond = true,
		-- event = { "BufReadPre", "BufNewFile" },
		opts = {
			formatters_by_ft = {
				javascript = { "prettierd", "eslint_d" },
				mjs = { "prettierd" },
				mdx = { "prettierd" },
				typescript = { "prettierd", "eslint_d" },
				javascriptreact = { "prettierd", "eslint_d" },
				typescriptreact = { "prettierd", "eslint_d" },
				svelte = { "prettierd", "eslint_d" },
				astro = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				graphql = { "prettierd" },
				liquid = { "prettierd" },
				lua = { "stylua" },
				python = { "isort", "black" },
				sh = { "shfmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false, -- if things don't work disable this!!!!
				timeout_ms = 1000,
			},
		},
	},

	-- ██╗███╗░░██╗███████╗░█████╗░██████╗░███╗░░░███╗░█████╗░████████╗██╗░█████╗░███╗░░██╗
	-- ██║████╗░██║██╔════╝██╔══██╗██╔══██╗████╗░████║██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
	-- ██║██╔██╗██║█████╗░░██║░░██║██████╔╝██╔████╔██║███████║░░░██║░░░██║██║░░██║██╔██╗██║
	-- ██║██║╚████║██╔══╝░░██║░░██║██╔══██╗██║╚██╔╝██║██╔══██║░░░██║░░░██║██║░░██║██║╚████║
	-- ██║██║░╚███║██║░░░░░╚█████╔╝██║░░██║██║░╚═╝░██║██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║
	-- ╚═╝╚═╝░░╚══╝╚═╝░░░░░░╚════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝
	-- {
	-- 	-- !devdocs
	-- 	"luckasRanarison/nvim-devdocs",
	-- 	cond = false,
	-- 	opts = {
	-- 		float_win = {
	-- 			width = 130,
	-- 			height = 40,
	-- 		},
	-- 		wrap = true,
	-- 	},
	-- 	cmd = {
	-- 		"DevdocsFetch",
	-- 		"DevdocsInstall",
	-- 		"DevdocsUninstall",
	-- 		"DevdocsOpen",
	-- 		"DevdocsOpenFloat",
	-- 		"DevdocsOpenCurrentFloat",
	-- 		"DevdocsToggle",
	-- 		"DevdocsUpdate",
	-- 		"DevdocsUpdateAll",
	-- 	},
	-- 	keys = {
	-- 		{
	-- 			keymaps.devdocs_toggle,
	-- 			"<cmd>DevdocsToggle<cr>",
	-- 			mode = { "n", "v" },
	-- 			desc = icons.keymaps.docs .. "toggle devdocs",
	-- 		},
	-- 		{
	-- 			keymaps.devdocs_open,
	-- 			"<cmd>DevdocsOpenFloat<cr>",
	-- 			mode = { "n", "v" },
	-- 			desc = icons.keymaps.docs .. "open devdocs",
	-- 		},
	-- 		{
	-- 			keymaps.devdocs_open_file,
	-- 			"<cmd>DevdocsOpenFloat<cr>",
	-- 			mode = { "n", "v" },
	-- 			desc = icons.keymaps.docs .. "open devdocs (file)",
	-- 		},
	-- 		{
	-- 			keymaps.devdocs_fetch,
	-- 			"<cmd>DevdocsFetch<cr>",
	-- 			mode = { "n", "v" },
	-- 			desc = icons.keymaps.docs .. "devdocs fetch",
	-- 		},
	-- 		{
	-- 			keymaps.devdocs_install,
	-- 			"<cmd>DevdocsInstall<cr>",
	-- 			mode = { "n", "v" },
	-- 			desc = icons.keymaps.docs .. "devdocs install",
	-- 		},
	-- 		{
	-- 			keymaps.devdocs_uninstall,
	-- 			"<cmd>DevdocsUninstall<cr>",
	-- 			mode = { "n", "v" },
	-- 			desc = icons.keymaps.docs .. "devdocs uninstall",
	-- 		},
	-- 		{
	-- 			keymaps.devdocs_update_all,
	-- 			"<cmd>DevdocsUpdateAll<cr>",
	-- 			mode = { "n", "v" },
	-- 			desc = icons.keymaps.docs .. "devdocs update all",
	-- 		},
	-- 	},
	-- },
	{
		-- !regexplainer
		"bennypowers/nvim-regexplainer",
		cond = false,
		event = { "BufReadPre", "BufWritePre" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "MunifTanjim/nui.nvim" },
		config = function()
			require("regexplainer").setup() -- press gR
		end,
	},
	{
		-- !follow-md-links
		-- INFO: key is <cr> to open the link
		"jghauser/follow-md-links.nvim",
		cond = false,
	},
	{
		-- screenkey
		"NStefan002/screenkey.nvim",
		cond = false,
		cmd = "Screenkey",
		version = "*",
		config = true,
		keys = {
			{
				keymaps.info_screenkey_toggle,
				"<cmd>Screenkey<cr>",
				desc = icons.keymaps.info .. "toggle screenkey",
			},
		},
	},

	-- ░█████╗░░█████╗░██████╗░██╗███╗░░██╗░██████╗░
	-- ██╔══██╗██╔══██╗██╔══██╗██║████╗░██║██╔════╝░
	-- ██║░░╚═╝██║░░██║██║░░██║██║██╔██╗██║██║░░██╗░
	-- ██║░░██╗██║░░██║██║░░██║██║██║╚████║██║░░╚██╗
	-- ╚█████╔╝╚█████╔╝██████╔╝██║██║░╚███║╚██████╔╝
	-- ░╚════╝░░╚════╝░╚═════╝░╚═╝╚═╝░░╚══╝░╚═════╝░
	{
		-- !autopairs
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true, -- enable treesitter
				ts_config = {
					lua = { "string" }, -- don't add pairs in lua string treesitter nodes
					javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
					java = false, -- don't check treesitter on java
				},
			})

			-- make autopairs and completion work together
			require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
		end,
	},
	{
		-- !tabout
		"abecodes/tabout.nvim",
		event = "InsertCharPre",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
		},
		opts = {
			tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
			backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
			act_as_tab = true, -- shift content if tab out is not possible
			act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
			default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
			default_shift_tab = "<C-d>", -- reverse shift default action,
			enable_backwards = true, -- well ...
			completion = false, -- if the tabkey is used in a completion pum
			tabouts = {
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = "`", close = "`" },
				{ open = "(", close = ")" },
				{ open = "[", close = "]" },
				{ open = "{", close = "}" },
			},
			ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
			exclude = {}, -- tabout will ignore these filetypes
		},
		config = function(_, opts)
			-- Setup function is required
			require("tabout").setup(opts)
		end,
		priority = 1000,
	},
	{
		-- !comment
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			-- import comment plugin safely
			local comment = require("Comment")

			local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

			-- enable comment
			comment.setup({
				-- for commenting tsx, jsx, svelte, html files
				pre_hook = ts_context_commentstring.create_pre_hook(),
			})
		end,
	},
	{
		-- !substitute
		"gbprod/substitute.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local substitute = require("substitute")

			substitute.setup()

			-- set keymaps

			-- vim.keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
			-- vim.keymap.set("n", "ss", substitute.line, { desc = "Substitute line" })
			-- vim.keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
			-- vim.keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })
		end,
		keys = {
			{ "s", "<cmd>lua require('substitute').operator()<cr>", desc = "substitute with motion" },
			{ "ss", "<cmd>lua require('substitute').line()<cr>", desc = "substitute line" },
			{ "S", "<cmd>lua require('substitute').eol()<cr>", desc = "substitute until end of line" },
			{ "s", "<cmd>lua require('substitute').visual()<cr>", desc = "substitute visual", mode = "x" },
		},
	},
	{
		-- !surround
		"kylechui/nvim-surround",
		event = { "BufReadPre", "BufNewFile" },
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = true,
	},
	{
		-- !dial
		"monaqa/dial.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.constant.new({ elements = { "let", "const" } }),
					augend.constant.new({ elements = { "True", "False" } }),
					augend.constant.new({ elements = { "||", "&&" }, word = false }),
					augend.constant.new({ elements = { "true", "false" } }),
					augend.constant.new({ elements = { "and", "or" } }),
					augend.constant.new({ elements = { "===", "!==" }, word = false }),
					augend.constant.new({ elements = { "==", "!=" }, word = false }),
					augend.constant.new({ elements = { "- [ ]", "- [x]" }, word = false }),
					-- augend.case.new({ types = { "camelCase", "PascalCase" } }),
					-- augend.misc.alias.markdown_heaser,
				},
			})
		end,
		keys = {
			{
				keymaps.dial_increment,
				function()
					require("dial.map").manipulate("increment", "normal")
				end,
				desc = icons.keymaps.action .. "Cycle",
			},
		},
	},

	-- ████████╗███████╗░██████╗████████╗██╗███╗░░██╗░██████╗░
	-- ╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝██║████╗░██║██╔════╝░
	-- ░░░██║░░░█████╗░░╚█████╗░░░░██║░░░██║██╔██╗██║██║░░██╗░
	-- ░░░██║░░░██╔══╝░░░╚═══██╗░░░██║░░░██║██║╚████║██║░░╚██╗
	-- ░░░██║░░░███████╗██████╔╝░░░██║░░░██║██║░╚███║╚██████╔╝
	-- ░░░╚═╝░░░╚══════╝╚═════╝░░░░╚═╝░░░╚═╝╚═╝░░╚══╝░╚═════╝░
	{
		-- !neotest
		"nvim-neotest/neotest",
		cond = false,
		dependencies = { "nvim-neotest/nvim-nio", "nvim-neotest/neotest-jest", "marilari88/neotest-vitest" },
		opts = {
			status = { virtual_text = true },
			output = { open_on_run = true },
			-- quickfix = {
			-- open = function()
			-- if package.loaded["trouble.nvim"] then
			-- require("trouble").open({ mode = "quickfix", focus = false })
			-- else
			-- vim.cmd("copen")
			-- end
			-- end,
			-- },
		},
		config = function(_, opts)
			opts.adapters = {
				require("neotest-jest")({
					jestCommand = "npm test --",
					jestConfigFile = "custom.jest.config.ts",
					env = { CI = true },
					cwd = function()
						return vim.fn.getcwd()
					end,
				}),
				require("neotest-vitest"),
			}
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						-- Replace newline and tab characters with space for more compact diagnostics
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)

			-- if package.loaded["trouble.nvim"] then
			opts.consumers = opts.consumers or {}
			-- Refresh and auto close trouble after running tests
			-- opts.consumers.trouble = function(client)
			-- 	client.listeners.results = function(adapter_id, results, partial)
			-- 		if partial then
			-- 			return
			-- 		end
			-- 		local tree = assert(client:get_position(nil, { adapter = adapter_id }))
			--
			-- 		local failed = 0
			-- 		for pos_id, result in pairs(results) do
			-- 			if result.status == "failed" and tree:get_key(pos_id) then
			-- 				failed = failed + 1
			-- 			end
			-- 		end
			-- 		vim.schedule(function()
			-- 			local trouble = require("trouble")
			-- 			if trouble.is_open() then
			-- 				trouble.refresh()
			-- 				if failed == 0 then
			-- 					trouble.close()
			-- 				end
			-- 			end
			-- 		end)
			-- 		return {}
			-- 	end
			-- end
			-- end

			if opts.adapters then
				local adapters = {}
				for name, config in pairs(opts.adapters or {}) do
					if type(name) == "number" then
						if type(config) == "string" then
							config = require(config)
						end
						adapters[#adapters + 1] = config
					elseif config ~= false then
						local adapter = require(name)
						if type(config) == "table" and not vim.tbl_isempty(config) then
							local meta = getmetatable(adapter)
							if adapter.setup then
								adapter.setup(config)
							elseif meta and meta.__call then
								adapter(config)
							else
								error("Adapter " .. name .. " does not support setup")
							end
						end
						adapters[#adapters + 1] = adapter
					end
				end
				opts.adapters = adapters
			end

			require("neotest").setup(opts)
		end,
		keys = {
			{
				keymaps.test_file,
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = icons.keymaps.test .. "run file",
			},
			{
				keymaps.test_project,
				function()
					require("neotest").run.run(vim.uv.cwd())
				end,
				desc = icons.keymaps.test .. "run all test files",
			},
			{
				keymaps.run_nearest_test,
				function()
					require("neotest").run.run()
				end,
				desc = icons.keymaps.test .. "run nearest",
			},
			{
				keymaps.run_last_test,
				function()
					require("neotest").run.run_last()
				end,
				desc = icons.keymaps.test .. "run last",
			},
			{
				keymaps.toggle_test_summary,
				function()
					require("neotest").summary.toggle()
				end,
				desc = icons.keymaps.test .. "toggle summary",
			},
			{
				keymaps.show_test_output,
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = icons.keymaps.test .. "show output",
			},
			{
				keymaps.toggle_test_output,
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = icons.keymaps.test .. "toggle output panel",
			},
			{
				keymaps.stop_testing,
				function()
					require("neotest").run.stop()
				end,
				desc = icons.keymaps.test .. "stop",
			},
			{
				keymaps.debug_nearest_test,
				function()
					require("neotest").run.run({ strategy = "dap" })
				end,
				desc = icons.keymaps.test .. "debug nearest",
			},
		},
	},

	-- ██████╗░███████╗██████╗░██╗░░░██╗░██████╗░░██████╗░██╗███╗░░██╗░██████╗░
	-- ██╔══██╗██╔════╝██╔══██╗██║░░░██║██╔════╝░██╔════╝░██║████╗░██║██╔════╝░
	-- ██║░░██║█████╗░░██████╦╝██║░░░██║██║░░██╗░██║░░██╗░██║██╔██╗██║██║░░██╗░
	-- ██║░░██║██╔══╝░░██╔══██╗██║░░░██║██║░░╚██╗██║░░╚██╗██║██║╚████║██║░░╚██╗
	-- ██████╔╝███████╗██████╦╝╚██████╔╝╚██████╔╝╚██████╔╝██║██║░╚███║╚██████╔╝
	-- ╚═════╝░╚══════╝╚═════╝░░╚═════╝░░╚═════╝░░╚═════╝░╚═╝╚═╝░░╚══╝░╚═════╝░
	{
		-- !dap
		-- TODO: check if ts-node npm dependency is actually needed for nvim-dap
		"rcarriga/nvim-dap-ui",
		cond = false,
		event = "VeryLazy",
		dependencies = {
			{
				"mfussenegger/nvim-dap",
				config = function()
					local dap = require("dap")

					dap.adapters["pwa-node"] = {
						type = "server",
						host = "localhost",
						port = "${port}",
						executable = {
							command = "node",
							args = {
								vim.fn.stdpath("data")
									.. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
								"${port}",
							},
						},
					}

					for _, language in ipairs({ "typescript", "javascript" }) do
						dap.configurations[language] = {
							{
								type = "pwa-node",
								request = "launch",
								name = "Launch Current File (pwa-node)",
								cwd = "${workspaceFolder}",
								args = { "${file}" },
								sourceMaps = true,
								protocol = "inspector",
							},
							{
								type = "pwa-node",
								request = "launch",
								name = "Launch Current File (Typescript)",
								cwd = "${workspaceFolder}",
								runtimeArgs = { "--loader=ts-node/esm" },
								program = "${file}",
								runtimeExecutable = "node",
								sourceMaps = true,
								protocol = "inspector",
								outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
								skipFiles = { "<node_internals>/**", "node_modules" },
								resolveSourceMapLocations = {
									"${workspaceFolder}",
									"!**/node_modules/**",
								},
							},
						}
					end
				end,
				keys = {
					{
						keymaps.toggle_breakpoint,
						'<cmd>lua require("dap").toggle_breakpoint()<cr>',
						desc = icons.keymaps.bug .. "toggle breakpoint",
					},
					{
						keymaps.run_debugger,
						"<cmd>lua require('dap').continue()<CR>",
						desc = icons.keymaps.bug .. "run or continue",
						mode = "n",
					},
					{
						keymaps.terminate_debugger,
						"<cmd>lua require('dap').terminate()<CR>",
						desc = icons.keymaps.bug .. "terminate",
						mode = "n",
					},
					{
						keymaps.run_last_debugger,
						"<cmd>lua require('dap').run_last()<CR>",
						desc = icons.keymaps.bug .. "run last",
						mode = "n",
					},
				},
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	-- lazy.nvim:
	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvimtools/hydra.nvim",
		},
		opts = {},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
		keys = {
			{
				mode = { "v", "n" },
				"<Leader>m",
				"<cmd>MCstart<cr>",
				desc = "Create a selection for selected text or word under the cursor",
			},
		},
	},
	--[[


  <div class="mt-3 flex -space-x-2 overflow-hidden">
    <img class="inline-block h-12 w-12 rounded-maximaring-2 ring-okay so another thing that you should keep in mind ism" src="https://images.unsplash.com/photo-1491528323818-fdd1faba62cc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt=""/>
    <img class="inline-block h-12 w-12 rounded-maximaring-2 ring-okay so another thing that you should keep in mind ism" src="https://images.unsplash.com/photo-1550525811-e5869dd03032?ixlib=rb-1.2.1&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt=""/>
    <img class="inline-block h-12 w-12 rounded-maximaring-2 ring-okay so another thing that you should keep in mind ism" src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2.25&w=256&h=256&q=80" alt=""/>
    <img class="inline-block h-12 w-12 rounded-maximaring-2 ring-okay so another thing that you should keep in mind ism" src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt=""/>
    <img class="inline-block h-12 w-12 rounded-maximaring-2 ring-okay so another thing that you should keep in mind ism" src="https://images.unsplash.com/photo-1517365830460-955ce3ccd263?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt=""/>
  </div>



  ]]

	-- ██████╗░██╗░█████╗░░██████╗░███╗░░██╗░█████╗░░██████╗████████╗██╗░█████╗░░██████╗
	-- ██╔══██╗██║██╔══██╗██╔════╝░████╗░██║██╔══██╗██╔════╝╚══██╔══╝██║██╔══██╗██╔════╝
	-- ██║░░██║██║███████║██║░░██╗░██╔██╗██║██║░░██║╚█████╗░░░░██║░░░██║██║░░╚═╝╚█████╗░
	-- ██║░░██║██║██╔══██║██║░░╚██╗██║╚████║██║░░██║░╚═══██╗░░░██║░░░██║██║░░██╗░╚═══██╗
	-- ██████╔╝██║██║░░██║╚██████╔╝██║░╚███║╚█████╔╝██████╔╝░░░██║░░░██║╚█████╔╝██████╔╝
	-- ╚═════╝░╚═╝╚═╝░░╚═╝░╚═════╝░╚═╝░░╚══╝░╚════╝░╚═════╝░░░░╚═╝░░░╚═╝░╚════╝░╚═════╝░
	{
		-- !lsp-lines
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		cond = true,
		lazy = false,
		config = function()
			require("lsp_lines").setup()
			vim.diagnostic.config({
				virtual_text = false,
			})
			-- Fixes the doubled virtual text in :Lazy
			vim.diagnostic.config({ virtual_lines = false }, require("lazy.core.config").ns)

			-- Do not highlight the entire diagnostic line
			-- vim.diagnostic.config({ virtual_lines = { highlight_whole_line = false } })
			vim.diagnostic.config({ virtual_lines = false })
		end,
		keys = {
			{
				keymaps.toggle_diagnostic_lines,
				'<cmd>lua require("lsp_lines").toggle()<CR>',
				mode = "n",
				desc = icons.keymaps.diagnostic .. "toggle line diagnostics",
			},
		},
	},

	-- ███╗░░██╗░█████╗░██╗░░░██╗██╗░██████╗░░█████╗░████████╗██╗░█████╗░███╗░░██╗
	-- ████╗░██║██╔══██╗██║░░░██║██║██╔════╝░██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
	-- ██╔██╗██║███████║╚██╗░██╔╝██║██║░░██╗░███████║░░░██║░░░██║██║░░██║██╔██╗██║
	-- ██║╚████║██╔══██║░╚████╔╝░██║██║░░╚██╗██╔══██║░░░██║░░░██║██║░░██║██║╚████║
	-- ██║░╚███║██║░░██║░░╚██╔╝░░██║╚██████╔╝██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║
	-- ╚═╝░░╚══╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝
	{
		-- !telescope
		"nvim-telescope/telescope.nvim",

		branch = "0.1.x",
		cmd = { "Telescope", "TodoTelescope" },
		event = { "BufWritePre", "BufReadPre" },
		dependencies = {
			{
				"nvim-lua/plenary.nvim",
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
        -- Note the plugin is bugged. Go to the plugin's repo at %localappdata%/nvim-data/telescope-fzf-native.nvim and run this command
				build = "zig cc -O3 -Wall -Werror -fpic -std=gnu99 -shared src/fzf.c -o build/libfzf.dll",
			},
			{ "nvim-tree/nvim-web-devicons" },
			{ "folke/todo-comments.nvim" },
			-- { "nvim-telescope/telescope-file-browser.nvim" },
			{ "crispgm/telescope-heading.nvim" },
			{ "nvim-telescope/telescope-symbols.nvim" },
			{ "debugloop/telescope-undo.nvim" },
			{ "piersolenski/telescope-import.nvim" },
			-- Use regular branch once the PR gets merged
			{
				"SichangHe/nvim-telescope--telescope-media-files.nvim",
				dependencies = { "nvim-lua/popup.nvim" },
				branch = "kitty-workaround",
			},
			{ "nvim-telescope/telescope-project.nvim" },
		},
		config = function()
			local telescope = require("telescope")
			local telescope_state = require("telescope.state")
			local telescope_action_state = require("telescope.actions.state")

			local telescroll = function(prompt_bufnr, opts)
				local previewer = telescope_action_state.get_current_picker(prompt_bufnr).previewer
				local status = telescope_state.get_status(prompt_bufnr)

				if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
					return
				end

				local speed, direction

				if opts.direction == "down" then
					direction = -1
				end
				if opts.direction == "up" then
					direction = 1
				end
				if opts.amount == "page" then
					speed = vim.api.nvim_win_get_height(status.preview_win)
				end
				if type(opts.amount) == "number" then
					speed = opts.amount
				end

				previewer:scroll_fn(speed * direction)
			end

			telescope.setup({
				extensions = {
					file_browser = {
						hijack_netrw = true,
					},
					heading = {
						treesitter = true,
					},
				},

				defaults = {
					layout_config = {
						prompt_position = "top",
						height = 0.999,
						width = 0.999,
					},

					sorting_strategy = "ascending",
					path_display = { "smart" },
					mappings = {
						n = {
							["n"] = function(bufnr)
								telescroll(bufnr, { amount = 4, direction = "down" })
							end,
							["e"] = function(bufnr)
								telescroll(bufnr, { amount = 4, direction = "up" })
							end,
						},
					},
				},
			})

			local extensions = {
				"fzf",
				"project", --[[ "file_browser", ]]
				"heading",
				"undo",
				"import",
				"noice",
				"media_files",
			}

			for _, extension in ipairs(extensions) do
				telescope.load_extension(extension)
			end
		end,
		keys = {
			{
				keymaps.telescope_diagnostics,
				"<cmd>Telescope diagnostics<CR>",
				mode = "n",
				desc = icons.keymaps.diagnostic .. "diagnostics",
			},
			{
				keymaps.quickfixes,
				"<cmd>Telescope quickfix<CR>",
				mode = "n",
				desc = icons.keymaps.diagnostic .. "quickfixes",
			},
			{
				keymaps.grep_cwd,
				"<cmd>Telescope live_grep<CR>",
				mode = "n",
				desc = icons.keymaps.search .. "grep in current directory",
			},
			{
				keymaps.media_files,
				"<cmd>Telescope media_files<CR>",
				mode = "n",
				desc = icons.keymaps.explorer .. "preview media files",
			},
			{
				keymaps.grep_file,
				"<cmd>Telescope current_buffer_fuzzy_find<CR>",
				mode = "n",
				desc = icons.keymaps.search .. "grep in document",
			},
			{
				keymaps.recent_files,
				"<cmd>Telescope oldfiles<CR>",
				mode = "n",
				desc = icons.keymaps.explorer .. "recent files",
			},
			{
				keymaps.find_files,
				"<cmd>Telescope find_files<CR>",
				mode = "n",
				desc = icons.keymaps.explorer .. "find files (cwd)",
			},
			-- {
			-- 	keymaps.explorer_cwd,
			-- 	"<cmd>Telescope file_browser path=%:p:h<CR>",
			-- 	mode = "n",
			-- 	desc = icons.keymaps.explorer .. "file explorer (cwd)",
			-- },
			-- {
			-- 	keymaps.explorer_ideas,
			-- 	"<cmd>Telescope file_browser path=~/thoughts-ideas/ideas<CR>",
			-- 	mode = "n",
			-- 	desc = icons.keymaps.explorer .. "ideas folder",
			-- },
			{
				keymaps.explorer_project,
				"<cmd>Telescope file_browser<CR>",
				mode = "n",
				desc = icons.keymaps.explorer .. "file explorer (root dir)",
			},
			{
				keymaps.explorer_projects,
				"<cmd>Telescope project<CR>",
				mode = "n",
				desc = icons.keymaps.explorer .. "projects",
			},

			-- +action
			{ keymaps.import, "<cmd>Telescope import<CR>", mode = "n", desc = icons.keymaps.action .. "import" },
			{ keymaps.icon, "<cmd>Telescope symbols<CR>", mode = "n", desc = icons.keymaps.action .. "insert icon" },

			-- +info
			{
				keymaps.todos,
				"<cmd>TodoTelescope<cr>",
				desc = icons.keymaps.info .. "see todos",
			},
			{
				keymaps.message_history,
				"<cmd>Telescope noice<CR>",
				mode = "n",
				desc = icons.keymaps.info .. "noice history",
			},
			{
				keymaps.undo_history,
				"<cmd>Telescope undo<CR>",
				mode = "n",
				desc = icons.keymaps.info .. "undo history",
			},
			{
				keymaps.headings,
				"<cmd>Telescope heading<CR>",
				mode = "n",
				desc = icons.keymaps.info .. "show headings",
			},
			{
				keymaps.grep_string,
				"<cmd>Telescope grep_string<CR>",
				mode = "n",
				desc = icons.keymaps.search .. "find string",
			},
			{ keymaps.open_todo, "<cmd>TodoTelescope<CR>", mode = "n", desc = icons.keymaps.open .. "find todos" },
			{
				keymaps.references,
				"<cmd>Telescope lsp_references<CR>",
				mode = "n",
				desc = icons.keymaps.search .. "references (telescope)",
			},
			{
				keymaps.incoming_calls,
				"<cmd>Telescope lsp_incoming_calls<CR>",
				mode = "n",
				desc = icons.keymaps.search .. "incoming calls (telescope)",
			},
			{
				keymaps.outgoing_calls,
				"<cmd>Telescope lsp_outgoing_calls<CR>",
				mode = "n",
				desc = icons.keymaps.search .. "outgoing calls (telescope)",
			},
			{
				keymaps.symbols_file,
				"<cmd>Telescope lsp_document_symbols<CR>",
				mode = "n",
				desc = icons.keymaps.search .. "document symbols (telescope)",
			},
			{
				keymaps.symbols_project,
				"<cmd>Telescope lsp_workspace_symbols<CR>",
				mode = "n",
				desc = icons.keymaps.search .. "workspace symbols (telescope)",
			},
			{
				keymaps.implementations,
				"<cmd>Telescope lsp_implementations<CR>",
				mode = "n",
				desc = icons.keymaps.search .. "implementations (telescope)",
			},
			{
				keymaps.definitions,
				"<cmd>Telescope lsp_definitions<CR>",
				mode = "n",
				desc = icons.keymaps.search .. "definitions (telescope)",
			},
			{
				keymaps.type_definitions,
				"<cmd>Telescope lsp_type_definitions<CR>",
				mode = "n",
				desc = icons.keymaps.search .. "type definitions (telescope)",
			},
			{
				keymaps.buffers,
				"<cmd>Telescope buffers<CR>",
				mode = "n",
				desc = icons.keymaps.search .. "Buffers (telescope)",
			},
		},
	},
	{
		-- !arrow
		"otavioschwanck/arrow.nvim",
		cond = false,
		opts = {
			window = {
				border = "rounded",
			},
			hide_handbook = false,
			show_icons = true,
			leader_key = keymaps.arrow_leader,
			index_keys = "arstneioARSTNEIO[({:=!?'",
			mappings = keymaps.arrow,
		},
	},

	-- ███╗░░░███╗░█████╗░██╗░░░██╗███████╗███╗░░░███╗███████╗███╗░░██╗████████╗
	-- ████╗░████║██╔══██╗██║░░░██║██╔════╝████╗░████║██╔════╝████╗░██║╚══██╔══╝
	-- ██╔████╔██║██║░░██║╚██╗░██╔╝█████╗░░██╔████╔██║█████╗░░██╔██╗██║░░░██║░░░
	-- ██║╚██╔╝██║██║░░██║░╚████╔╝░██╔══╝░░██║╚██╔╝██║██╔══╝░░██║╚████║░░░██║░░░
	-- ██║░╚═╝░██║╚█████╔╝░░╚██╔╝░░███████╗██║░╚═╝░██║███████╗██║░╚███║░░░██║░░░
	-- ╚═╝░░░░░╚═╝░╚════╝░░░░╚═╝░░░╚══════╝╚═╝░░░░░╚═╝╚══════╝╚═╝░░╚══╝░░░╚═╝░░░
	{
		-- !flash
		"folke/flash.nvim",
		cond = false,
		opts = {},
		event = { "CmdlineEnter" },
		keys = {
			{
				keymaps.jump,
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = icons.keymaps.lightning .. "jump",
			},
			{
				keymaps.select_around_node,
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = icons.keymaps.lightning .. "select around node",
			},
			{
				keymaps.search_select_node,
				mode = { "n", "v", "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = icons.keymaps.lightning .. "search and select node",
			},
		},
	},
	{
		-- !spider
		"chrisgrieser/nvim-spider",
		config = function()
			vim.keymap.set(
				{ "n", "o", "x" },
				"e",
				"<cmd>lua require('spider').motion('w')<CR>",
				{ desc = "which_key_ignore" }
			)
			vim.keymap.set(
				{ "n", "o", "x" },
				"m",
				"<cmd>lua require('spider').motion('b')<CR>",
				{ desc = "which_key_ignore" }
			)
		end,
	},
	{
		-- !plenary
		"nvim-lua/plenary.nvim",
	},
	{
		-- !numb
		"nacro90/numb.nvim",
		opts = {},
	},
	{
		-- !auto-session
		"rmagatti/auto-session",
		cond = false,
		config = function()
			local auto_session = require("auto-session")

			auto_session.setup({
				auto_restore_enabled = true,
				auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
			})

			vim.keymap.set(
				"n",
				keymaps.restore_session,
				"<cmd>SessionRestore<CR>",
				{ desc = icons.keymaps.window .. "restore session" }
			)
		end,
	},
	{
		-- !codesnap
		"mistricky/codesnap.nvim",
		cond = false,
		build = "make",
		opts = {
			mac_window_bar = false,
			code_font_family = "JetBrainsMono Nerd Font",
			watermark = "",
			has_breadcrumbs = true,
		},
		keys = {
			{ keymaps.code_screenshot, "<cmd>CodeSnap<cr>", desc = "code screenshot", mode = "v" },
			{ keymaps.code_screenshot_save, "<cmd>CodeSnapSave<cr>", desc = "code screenshot (save)", mode = "v" },
		},
	},
	{
		-- !genghis
		"chrisgrieser/nvim-genghis",
		cond = true,
		dependencies = { "stevearc/dressing.nvim" },
		keys = {
			{
				keymaps.rename_file,
				function()
					require("genghis").renameFile()
				end,
				desc = icons.keymaps.file .. "rename file and update imports",
			},
			{
				keymaps.move_file,
				function()
					require("genghis").moveAndRenameFile()
				end,
				desc = icons.keymaps.file .. "move and rename",
			},
			{
				keymaps.move_file_to_folder,
				function()
					require("genghis").moveToFolderInCwd()
				end,
				desc = icons.keymaps.file .. "move to folder",
			},
			-- { keymaps.trash_file, "<cmd>Trash<cr>", desc = icons.keymaps.file .. "move to trash" },
			-- { keymaps.copy_file_path, "<cmd>CopyFilePath<cr>", desc = icons.keymaps.file .. "copy path" },
			-- { keymaps.copy_folder_path, "<cmd>CopyDirectoryPath<cr>", desc = icons.keymaps.file .. "copy folder path" },
			-- { keymaps.copy_file_name, "<cmd>CopyFilename<cr>", desc = icons.keymaps.file .. "copy file name" },
			-- {
			-- 	keymaps.chmodx,
			-- 	"<cmd>Chmodx<cr>",
			-- 	desc = icons.keymaps.file .. "make file executable (chmodx)",
			-- },
		},
	},
	{
		-- !lazygit
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				keymaps.lazygit_project,
				"<cmd>LazyGit<cr>",
				desc = icons.keymaps.git .. "git manager (project)",
			},
			{
				keymaps.lazygit_file,
				"<cmd>LazyGitCurrentFile<cr>",
				desc = icons.keymaps.git .. "git manager (file)",
			},
			{
				keymaps.lazygit_commits_project,
				"<cmd>LazyGitFilter<cr>",
				desc = icons.keymaps.git .. "git commit manager (project)",
			},
			{
				keymaps.lazygit_commits_file,
				"<cmd>LazyGitFilterCurrentFile<cr>",
				desc = icons.keymaps.git .. "git commit manager (file)",
			},
		},
	},
	{
		-- !rainbow-delimiters
		"HiPhish/rainbow-delimiters.nvim",
		event = { "BufEnter", "BufReadPre" },
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = function(bufnr)
						local large_file = vim.api.nvim_buf_line_count(bufnr) > 10000
						return (not large_file) and rainbow_delimiters.strategy["global"] or nil
					end,
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
					query = function(bufnr)
						-- Use blocks for `:InspectTree`
						local is_inspecttree = vim.b[bufnr].dev_base ~= nil
						return is_inspecttree and "rainbow-blocks" or "rainbow-delimiters"
					end,
					latex = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterViolet",
				},
			}
		end,
	},
	{
		-- !colorizer !nvchad !nvchad-colorizer
		-- "NvChad/nvim-colorizer.lua",
		"catgoose/nvim-colorizer.lua",
		branch = "tailwind_add_ring_prefixes",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			user_default_options = {
				tailwind = true,
				css = true, -- enabled HSL and RGB functions
				RRGGBBAA = true,
				AARRGGBB = true,
			},
		},
	},
	{
		-- !dressing
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			-- setup function is required
			require("gitsigns").setup()
		end,
	},
	{
		-- !dashboard
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		cond = false,
		keys = {
			{ keymaps.open_dashboard, "<cmd>Dashboard<cr>", desc = icons.keymaps.open .. "open dashboard" },
		},
		opts = function()
			local opts = {
				theme = "doom",
				hide = {
					-- this is taken care of by lualine
					-- enabling this messes up the actual laststatus setting after loading a file
					statusline = false,
				},
				config = {
					header = { "" },
					week_header = { enable = true },
					center = {
						{
							action = "Telescope project",
							desc = " open project",
							-- icon = " ",
							key = "a",
						},
						{
							action = "Telescope file_browser",
							desc = " file explorer",
							-- icon = " ",
							key = "r",
						},
						{
							action = "Telescope live_grep",
							desc = " grep",
							-- icon = " ",
							key = "s",
						},
						{
							action = "Telescope oldfiles",
							desc = " recent files",
							-- icon = " ",
							key = "t",
						},
						{
							action = "LazyGit",
							desc = " lazygit",
							-- icon = " ",
							key = "n",
						},
						{
							action = "SessionRestore",
							desc = " restore session",
							-- icon = " ",
							key = "e",
						},
						{
							action = "e ~/thoughts-ideas/todo.md",
							desc = " todos",
							-- icon = " ",
							key = "i",
						},
						{
							action = "qa",
							desc = " quit",
							-- icon = " ",
							key = "o",
						},
					},
					footer = { "" },
					-- footer = function()
					-- 	local stats = require("lazy").stats()
					-- 	local ms = math.floor(math.floor(stats.startuptime * 100 + 0.5) / 100)
					-- 	return {
					-- 		"loaded " .. stats.loaded .. " plugins in " .. ms .. " ms",
					-- 	}
					-- end,
				},
			}

			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
				button.key_format = "  %s"
			end

			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "DashboardLoaded",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			return opts
		end,
	},
	{
		-- !git-blame
		"f-person/git-blame.nvim",
		opts = {
			enabled = false,
		},
		keys = {
			{ keymaps.git_blame_toggle, "<cmd>GitBlameToggle<cr>", desc = icons.keymaps.git .. "toggle git blame" },
		},
	},
	{
		-- !lualine
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			options = {
				theme = "auto",
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard" } },
			},
			sections = {
				lualine_a = {
					"mode",
				},
				lualine_b = {
					"branch",
					"diff",
					{
						"diagnostics",
						symbols = icons.lualine,
					},
				},
				lualine_c = {
					{
						"progress",
					},
					{
						function()
							local words = vim.fn.wordcount()["words"]
							return "Words: " .. words
						end,
						cond = function()
							local ft = vim.opt_local.filetype:get()
							local count = {
								latex = true,
								tex = true,
								text = true,
								markdown = true,
								vimwiki = true,
							}
							return count[ft] ~= nil
						end,
					},
				},
				lualine_x = {},
				lualine_y = {
					{
						function()
							local type = vim.api.nvim_get_option_value("filetype", { buf = 0 })
							local file = vim.fn.expand("%:p:t")
							local path = vim.fn.expand("%:p:h:t")
							local the_file = path .. "/" .. file
							local icon = require("nvim-web-devicons").get_icon(vim.fn.expand("%:t"))

							if file == "" then
								the_file = ""
							end -- Buffer
							if file == "[packer]" then
								the_file = "[packer]"
							end
							if file == "[BOXdash]" then
								the_file = "[BOXdash]"
							end
							if type == "help" then
								the_file = "[help]: " .. file
							end
							if type == "lazy" then
								the_file = "[lazy.nvim]"
							end
							if the_file == ".git/COMMIT_EDITMSG" then
								the_file = "[Git commit]"
							end

							return the_file .. " " .. icon .. " "
						end,
					},
				},
				lualine_z = {
					function()
						local timeformat = os.date("%I") .. ":" .. os.date("%M") .. " " .. os.date("%p")

						local function starts(String, Start)
							return string.sub(String, 1, string.len(Start)) == Start
						end

						if starts(timeformat, "0") then
							return string.sub(timeformat, 2, -1)
						end
						return timeformat
					end,
				},
			},
		},
	},
	{
		-- !todo-comments
		"folke/todo-comments.nvim",
		cond = false,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false,
			after = "",
		},
	},
	{
		-- !catppuccin
		"catppuccin/nvim",
		opts = {
			integrations = {
				neotest = true,
				noice = true,
				which_key = true,
				mason = true,
			},
			styles = {
				functions = { "bold" },
			},
		},
		config = function(_, opts)
			-- Setup function is required
			require("catppuccin").setup(opts)
			vim.cmd([[colorscheme catppuccin]])

			-- Disable underlines for diagnostic highlights
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = false, underline = false })
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = false, underline = false })
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = false, underline = false })
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = false, underline = false })
		end,
	},
	{
		-- !nvterm
		"NvChad/nvterm",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				keymaps.terminal_toggle_floating,
				'<cmd>lua require("nvterm.terminal").toggle("float")<cr>',
				desc = icons.keymaps.terminal .. "toggle floating terminal",
			},
			{
				keymaps.terminal_toggle_horizontal,
				'<cmd>lua require("nvterm.terminal").toggle("horizontal")<cr>',
				desc = icons.keymaps.terminal .. "toggle horizontal terminal",
			},
			{
				keymaps.terminal_toggle_vertical,
				'<cmd>lua require("nvterm.terminal").toggle("vertical")<cr>',
				desc = icons.keymaps.terminal .. "toggle vertical terminal",
			},
		},
		config = function()
			-- Setup function is required
			require("nvterm").setup()
		end,
	},
	{
		-- !indent-blankline
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "┊" },
		},
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		config = function()
			require("typescript-tools").setup({})
			vim.keymap.set(
				{ "n" },
				keymaps.ts_rename_file,
				"<cmd>TSToolsRenameFile<cr>",
				{ desc = icons.keymaps.action .. "rename file" }
			)
			vim.keymap.set(
				{ "n" },
				keymaps.lsp_ts_goto_definition,
				"<cmd>TSToolsGoToSourceDefinition<cr>",
				{ desc = icons.keymaps.action .. "goto source definition" }
			)
			vim.keymap.set(
				{ "n" },
				keymaps.ts_add_missing_imports,
				"<cmd>TSToolsAddMissingImports<cr>",
				{ desc = icons.keymaps.action .. "add missing imports" }
			)
			vim.keymap.set(
				{ "n" },
				keymaps.ts_remove_unused_imports,
				"<cmd>TSToolsRemoveUnusedImports<cr>",
				{ desc = icons.keymaps.action .. "remove unused imports" }
			)
		end,
	},
	{
		-- !which-key
		"folke/which-key.nvim",
		version = "2.1.0",
		-- event = { "BufReadPre", "BufNewFile" },
		opts = {
			plugins = {
				presets = {
					motions = false,
					windows = false,
					nav = false,
					text_objects = false,
				},
			},
			operators = {
				s = "substitute",
			},
			key_labels = {
				["<leader>"] = "leader",
				["<tab>"] = "tab",
				["<Right>"] = "right",
				["<Left>"] = "left",
				["<Down>"] = "down",
				["<C-Down>"] = "ctrl-down",
				["<C-Up>"] = "ctrl-up",
				["<C-Right>"] = "ctrl-right",
				["<C-Left>"] = "ctrl-left",
				["<Up>"] = "up",
				["<CR>"] = "return",
				["<BS>"] = "backspace",
			},
			window = {
				border = "single",
				position = "bottom",
			},
			hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua ", "$" },
			layout = {
				align = "center",
				spacing = 9,
			},
			show_help = false,
			icons = icons.which_key,
		},
		config = function(_, opts)
			local wk = require("which-key")
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			wk.setup(opts)
			wk.register({
				["<leader>"] = {
					["<leader>"] = { "macro" },
					name = icons.keymaps.operator .. "command",
					a = { name = icons.keymaps.terminal .. "terminal" },
					e = { name = icons.keymaps.explorer .. "explorer" },
					o = { name = icons.keymaps.open .. "goto" },
					i = { name = icons.keymaps.search .. "find" },
					m = {
						name = icons.keymaps.bug .. "debug",
					},
					g = { name = icons.keymaps.test .. "test" },
					f = { name = icons.keymaps.docs .. "docs" },
					w = { name = icons.keymaps.diagnostic .. "diagnostic" },
					s = { name = icons.keymaps.window .. "window" },
					n = { name = icons.keymaps.action .. "action" },
					t = { name = icons.keymaps.info .. "info" },
					u = { name = icons.keymaps.file .. "file" },
					r = { name = icons.keymaps.git .. "git" },
					z = {
						name = icons.keymaps.operator .. "command",
					},
				},
				["["] = { name = icons.keymaps.operator .. "last" },
				["!"] = { name = icons.keymaps.operator .. "filter" },
				["]"] = { name = icons.keymaps.operator .. "next" },
				["<CR>"] = { desc = "quick open" },
				["<C-h>"] = { desc = "which_key_ignore" },
				["<C-k>"] = { desc = "which_key_ignore" },
				["<C-Bslash>"] = { desc = "which_key_ignore" },
				["<C-j>"] = { desc = "which_key_ignore" },
				["<C-l>"] = { desc = "which_key_ignore" },
				["<"] = { name = icons.keymaps.operator .. "indent-left" },
				["&"] = { name = "which_key_ignore" },
				[";"] = { name = "which_key_ignore" },
				[","] = { name = "which_key_ignore" },
				["%"] = { name = "which_key_ignore" },
				[">"] = { name = icons.keymaps.operator .. "indent-right" },
				k = { name = "filter" },
				Y = { desc = "which_key_ignore" },
				S = { desc = "which_key_ignore" },
				K = { name = "which_key_ignore" },
				t = { desc = "which_key_ignore" },
				T = { desc = "which_key_ignore" },
				s = { name = icons.keymaps.operator .. "substitute", mode = { "o", "x", "n", "v" } },
				f = { desc = "which_key_ignore" },
				F = { desc = "which_key_ignore" },
				y = { name = icons.keymaps.operator .. "yank" },
				v = { name = icons.keymaps.operator .. "visual" },
				z = { name = icons.keymaps.operator .. "fold" },
				d = { name = icons.keymaps.operator .. "delete" },
				c = { name = icons.keymaps.operator .. "change" },
				g = { name = icons.keymaps.operator .. "goto" },
			})

			wk.register({
				a = { name = "around" },
				i = { name = "inside" },
				["["] = { name = "last" },
				["]"] = { name = "next" },
				["ip"] = [[paragraph]],
				["ap"] = [[paragraph]],
				["is"] = [[sentence]],
				["as"] = [[sentence]],
				["it"] = [[tag]],
				["at"] = [[tag]],
				["iw"] = [[word]],
				["aw"] = [[word]],
				["iW"] = [[WORD]],
				["aW"] = [[WORD]],
				['i"'] = [[""]],
				['a"'] = [[""]],
				["i'"] = [['']],
				["a'"] = [['']],
				["i`"] = [[``]],
				["a`"] = [[``]],
				["i<lt>"] = [[<>]],
				["a<lt>"] = [[<>]],
				["i>"] = [[<>]],
				["a>"] = [[<>]],
				["i["] = "[]",
				["i]"] = "[]",
				["a["] = "[]",
				["a]"] = "[]",
				["i("] = [[()]],
				["i)"] = [[()]],
				["a("] = [[()]],
				["a)"] = [[()]],
				["ib"] = [[()]],
				["ab"] = [[()]],
				["i{"] = [[{}]],
				["i}"] = [[{}]],
				["a{"] = [[{}]],
				["a}"] = [[{}]],
				["iB"] = [[{}]],
				["aB"] = [[{}]],
			}, { mode = "o" })
		end,
	},
	{
		-- !noice
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			presets = {
				bottom_search = true,
				command_palette = true,
				lsp_doc_border = false,
				long_message_to_split = true,
				inc_rename = true,
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = {
					-- noice sends a message "No information available" on tailwind classes
					silent = true,
				},
				progress = {
					enabled = false,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
				-- Simply not show the messages that I gave up trying to fix.
				-- Feel free to PR if you find a fix for them
				{
					filter = {
						any = {
							{
								event = "notify",
								find = " ",
							},
							{
								event = "msg_show",
								find = " ",
							},
							-- INFO: This message happens when we try to format a package.json file
							{
								find = "method workspace/executeCommand is not supported by any of the servers registered for the current buffer",
							},
							{
								find = "Judging",
							},
							-- INFO: This message happens when we try to exit out of lazygit. The message doesn't appear if we remove the NvTerm plugin.
							{ find = "lazygit.lua:29:" },
							-- INFO: This message is the plugin author's misttake
							{ find = "attempt to call field 'iter'" },
						},
					},
					opts = { skip = true },
				},
			},
		},
	},
}

-- ██╗░░░░░░█████╗░███████╗██╗░░░██╗░░░███╗░░██╗██╗░░░██╗██╗███╗░░░███╗
-- ██║░░░░░██╔══██╗╚════██║╚██╗░██╔╝░░░████╗░██║██║░░░██║██║████╗░████║
-- ██║░░░░░███████║░░███╔═╝░╚████╔╝░░░░██╔██╗██║╚██╗░██╔╝██║██╔████╔██║
-- ██║░░░░░██╔══██║██╔══╝░░░░╚██╔╝░░░░░██║╚████║░╚████╔╝░██║██║╚██╔╝██║
-- ███████╗██║░░██║███████╗░░░██║░░░██╗██║░╚███║░░╚██╔╝░░██║██║░╚═╝░██║
-- ╚══════╝╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝╚═╝░░╚══╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝
-- !lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lazy_options = {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
}

-- most important line
require("lazy").setup(plugins, lazy_options)
