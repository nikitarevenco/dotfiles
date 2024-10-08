local function toggle_conceal()
	if vim.wo.conceallevel == 2 then
		vim.opt.conceallevel = 0
	else
		vim.opt.conceallevel = 2
	end
end

-- Disable conceal in markdown, mdx, and json files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "mdx", "json" },
	callback = function()
		vim.wo.conceallevel = 0
	end,
})

vim.g.markdown_recommended_style = 0
vim.g.mapleader = " "
vim.o.updatetime = 750
vim.opt.showtabline = 0
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.sidescrolloff = 8
vim.opt.smoothscroll = true
vim.opt.conceallevel = 2
vim.opt.wrap = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.mouse = ""
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard:append("unnamedplus")
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.shortmess:append("I")
vim.opt.undofile = true
vim.wo.number = false
vim.wo.relativenumber = false
vim.o.laststatus = 0
vim.cmd("hi! link StatusLine Normal")
vim.cmd("hi! link StatusLineNC Normal")
vim.cmd("set statusline=%{repeat('─',winwidth('.'))}")
vim.wo.signcolumn = "yes:1"
vim.opt.cmdheight = 0

vim.keymap.set("i", ",", ",<C-g>u", { desc = "add undo breakpoint" })
vim.keymap.set("i", ".", ".<C-g>u", { desc = "add undo breakpoint" })
vim.keymap.set("i", ";", ";<C-g>u", { desc = "add undo breakpoint" })
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "prev search result" })
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "move down" })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "move up" })
vim.keymap.set("v", "<", "<gv", { desc = "indent" })
vim.keymap.set("v", ">", ">gv", { desc = "dedent" })
vim.keymap.set(
	"n",
	"<leader>z",
	"<cmd>lua vim.wo.number = not vim.wo.number;vim.wo.relativenumber = not vim.wo.relativenumber<cr>",
	{ desc = "toggle line numbers" }
)
vim.keymap.set("i", "<c-z>", "<C-o>", { desc = "execute normal command" })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "escape and clear hlsearch" })
vim.keymap.set("n", "<bs>", "<cmd>edit #<cr>", { silent = true, desc = "alternate buffer" })
vim.keymap.set("n", "<leader>b", toggle_conceal, { desc = "toggle conceal" })
vim.keymap.set("t", "<esc>", "<cmd>ToggleTerm<cr>", { desc = "exit terminal mode" })
vim.keymap.set("i", "<C-d>", "<C-o><cmd>d<CR>", { desc = "delete line" })
vim.keymap.set("i", "<C-v>", "<esc>pa", { desc = "paste" })
vim.keymap.set("n", "gO", "<cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = "empty line below" })
vim.keymap.set("n", "go", "<cmd>call append(line('.'), repeat([''], v:count1))<CR>", { desc = "add empty line above" })
vim.keymap.set("x", "g/", "<esc>/\\%V", { silent = false, desc = "search inside visual selection" })
vim.keymap.set("n", "<right>", "<C-w>", { desc = "window commands" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "join line but keep cursor position" })
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<leader>x", "<cmd>qa!<cr>")

vim.keymap.set("n", "<leader>a", "O/**<cr>/<up><cr>")
vim.api.nvim_create_autocmd(
	{ "FocusLost", "ModeChanged", "TextChanged", "BufEnter" },
	{ desc = "autosave", pattern = "*", command = "silent! update" }
)

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "go to last loc when opening a buffer",
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

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	desc = "check if we need to reload the file when it changed",
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	desc = "resize splits if window got resized",
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "highlight on yank",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Let neovim recognize the plugin's path so we can require it
vim.opt.rtp:prepend(os.getenv("HOME") .. "/proj/instant-lsp.nvim")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("instant-lsp").setup({
		languages = {
			"lua",
			"markdown",
			"typescript",
			"mdx",
			"tailwind",
			"css",
			"git",
			"html",
			"json",
			"prisma",
			"shell",
			"yaml",
		},
		disable_feature = {
			snippets = false,
			ts_context = true,
			virtual_text = true,
			cmp_border = true,
		},
	}),
	{
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		keys = {
			{ "<leader>s", "<cmd>GrugFar<cr>", desc = "search and replace" },
		},
		opts = {},
	},
	{
		"akinsho/toggleterm.nvim",
		opts = {
			open_mapping = "<leader>e",
			insert_mappings = false,
			terminal_mappings = false,
			autochdir = true,
			shade_terminals = false,
			direction = "tab",
			shell = package.config:sub(1, 1) == "\\"
					and 'cmd.exe /s /k "clink inject -q && %userprofile%\\dotfiles\\doskeys.cmd"'
				or vim.o.shell,
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
		opts = {
			disable_hint = true,
			graph_style = "unicode",
			mappings = {
				commit_editor = {
					["<esc>"] = "Close",
				},
				status = {
					["<esc>"] = "Close",
				},
				rebase_editor = {
					["<esc>"] = "Close",
				},
			},
		},
		keys = {
			{
				"<leader>i",
				"<cmd>Neogit<CR>",
				mode = "n",
				desc = "neogit",
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		keys = {
			{ "<leader>y", "<cmd>FzfLua grep_project<cr>", desc = "grep" },
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				char = {
					enabled = false,
				},
			},
			label = {
				rainbow = {
					enabled = true,
					shade = 8,
				},
			},
		},
		keys = {
			{
				"<cr>",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
		},
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		opts = function()
			function _G.get_oil_winbar()
				local dir = require("oil").get_current_dir()
				if dir then
					return vim.fn.fnamemodify(dir, ":~")
				else
					return vim.api.nvim_buf_get_name(0)
				end
			end

			local detail = false

			local function parse_output(proc)
				local result = proc:wait()
				local ret = {}
				if result.code == 0 then
					for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
						-- Remove trailing slash
						line = line:gsub("/$", "")
						ret[line] = true
					end
				end
				return ret
			end

			local function new_git_status()
				return setmetatable({}, {
					__index = function(self, key)
						local ignore_proc = vim.system(
							{ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
							{
								cwd = key,
								text = true,
							}
						)
						local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, {
							cwd = key,
							text = true,
						})
						local ret = {
							ignored = parse_output(ignore_proc),
							tracked = parse_output(tracked_proc),
						}

						rawset(self, key, ret)
						return ret
					end,
				})
			end
			local git_status = new_git_status()

			local refresh = require("oil.actions").refresh
			local orig_refresh = refresh.callback
			refresh.callback = function(...)
				git_status = new_git_status()
				orig_refresh(...)
			end

			return {
				win_options = {
					winbar = "%!v:lua.get_oil_winbar()",
				},
				delete_to_trash = true,
				skip_confirm_for_simple_edits = true,
				keymaps = {
					["<left>"] = "actions.parent",
					["<right>"] = "actions.select",
					["<esc>"] = "actions.close",
					["?"] = {
						desc = "Toggle file detail view",
						callback = function()
							detail = not detail
							if detail then
								require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
							else
								require("oil").set_columns({ "icon" })
							end
						end,
					},
				},
				view_options = {
					view_options = {
						is_hidden_file = function(name, bufnr)
							local dir = require("oil").get_current_dir(bufnr)
							local is_dotfile = vim.startswith(name, ".") and name ~= ".."
							if not dir then
								return is_dotfile
							end
							if is_dotfile then
								return not git_status[dir].tracked[name]
							else
								return git_status[dir].ignored[name]
							end
						end,
					},
					is_always_hidden = function(name)
						return name == ".."
					end,
					sort = {
						{ "mtime", "desc" },
					},
				},
			}
		end,
		keys = {
			{
				"<left>",
				function()
					local oil = require("oil")
					oil.open()
					-- require("oil.util").run_after_load(0, function()
					-- 	oil.open_preview()
					-- end)
				end,
				desc = "file manager",
			},
		},
	},
	{
		"gbprod/substitute.nvim",
		opts = {},
		keys = {
			{ "s", "<cmd>lua require('substitute').operator()<cr>", desc = "substitute with motion" },
			{ "ss", "<cmd>lua require('substitute').line()<cr>", desc = "substitute line" },
			{ "S", "<cmd>lua require('substitute').eol()<cr>", desc = "substitute until end of line" },
			{ "s", "<cmd>lua require('substitute').visual()<cr>", desc = "substitute visual", mode = "x" },
		},
	},
	{
		"kylechui/nvim-surround",
		config = true,
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"chrisgrieser/nvim-spider",
		config = function()
			vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "forward" })
			vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "backward" })
			vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "backward" })
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		main = "rainbow-delimiters.setup",
		opts = {
			strategy = {
				[""] = function(bufnr)
					local large_file = vim.api.nvim_buf_line_count(bufnr) > 10000
					return (not large_file) and require("rainbow-delimiters").strategy["global"] or nil
				end,
			},
			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
				query = function(bufnr)
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
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = true,
				css = true,
				RRGGBBAA = true,
				AARRGGBB = true,
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{
		"catppuccin/nvim",
		opts = {
			integrations = {
				grug_far = true,
				mason = true,
			},
			styles = {
				functions = { "bold" },
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd([[colorscheme catppuccin]])

			for _, highlight in ipairs({
				"DiagnosticUnderlineError",
				"DiagnosticUnderlineWarn",
				"DiagnosticUnderlineInfo",
				"DiagnosticUnderlineHint",
			}) do
				vim.api.nvim_set_hl(0, highlight, { undercurl = false, underline = false })
			end
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "┊" },
		},
	},
	{
		"b0o/incline.nvim",
		opts = {
			window = {
				padding = 0,
				margin = { horizontal = 0 },
			},
			render = function(props)
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				if filename == "" then
					filename = "[No Name]"
				end

				local modified = vim.bo[props.buf].modified
				return {
					{ filename, gui = modified and "bold,italic" or "bold" },
					guibg = "#181825",
					guifg = "#cdd6f4",
				}
			end,
		},
	},
	{
		"samjwill/nvim-unception",
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		config = function()
			vim.keymap.set("n", "gx", function()
				require("various-textobjs").url()

				local foundURL = vim.fn.mode():find("v")
				if not foundURL then
					return
				end

				vim.cmd.normal({ '"zy', bang = true })
				local url = vim.fn.getreg("z")
				vim.ui.open(url)
			end, { desc = "URL Opener" })

			require("various-textobjs").setup({
				useDefaultKeymaps = false,
			})

			vim.keymap.set({ "o", "x" }, "r", "<cmd>lua require('various-textobjs').subword('inner')<cr>")
			vim.keymap.set({ "o", "x" }, "Z", "<cmd>lua require('various-textobjs').entireBuffer()<cr>")
			vim.keymap.set({ "o", "x" }, "m", "<cmd>lua require('various-textobjs').nearEoL()<cr>")
		end,
	},
}, {
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
})
