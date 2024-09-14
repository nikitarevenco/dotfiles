local function toggle_conceal()
	if vim.wo.conceallevel == 2 then
		vim.opt.conceallevel = 0
	else
		vim.opt.conceallevel = 2
	end
end

vim.g.markdown_recommended_style = 0
vim.g.mapleader = " "
vim.o.updatetime = 750
vim.opt.showtabline = 0
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.scrolloff = 10
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

-- vim.opt.rtp:prepend("C:\\Users\\micro\\repos\\instant-lsp.nvim")

local instant_lsp_path = vim.fn.stdpath("data") .. "/instant-lsp.nvim"

-- Clone the plugin onto your system
if not vim.loop.fs_stat(instant_lsp_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/nikitarevenco/instant-lsp.nvim",
		instant_lsp_path,
	})
end

-- Let neovim recognize the plugin's path so we can require it
vim.opt.rtp:prepend(instant_lsp_path)

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
		languages = { "lua", "markdown" },
		disable_feature = {
			snippets = true,
			ts_context = true,
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
			shell = vim.fn.has("win32") and 'cmd.exe /s /k "clink inject -q && %userprofile%\\dotfiles\\doskeys.cmd"'
				or "zsh",
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
					require("oil.util").run_after_load(0, function()
						oil.open_preview()
					end)
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

			vim.keymap.set({ "o", "x" }, "ie", "<cmd>lua require('various-textobjs').subword('inner')<cr>")
			vim.keymap.set({ "o", "x" }, "ae", "<cmd>lua require('various-textobjs').subword('outer')<cr>")
			vim.keymap.set({ "o", "x" }, "Z", "<cmd>lua require('various-textobjs').entireBuffer()<cr>")
			vim.keymap.set({ "o", "x" }, "m", "<cmd>lua require('various-textobjs').nearEoL()<cr>")
			vim.keymap.set({ "o", "x" }, "q", "<cmd>lua require('various-textobjs').lineCharacterwise('inner')<cr>")
			vim.keymap.set({ "o", "x" }, "iv", "<cmd>lua require('various-textobjs').value('inner')<cr>")
			vim.keymap.set({ "o", "x" }, "av", "<cmd>lua require('various-textobjs').value('outer')<cr>")
			vim.keymap.set({ "o", "x" }, "ik", "<cmd>lua require('various-textobjs').key('inner')<cr>")
			vim.keymap.set({ "o", "x" }, "ak", "<cmd>lua require('various-textobjs').key('outer')<cr>")
			vim.keymap.set({ "o", "x" }, "u", "<cmd>lua require('various-textobjs').url()<cr>", { desc = "url" })
			vim.keymap.set({ "o", "x" }, "ig", "<cmd>lua require('various-textobjs').chainMember('inner')<cr>")
			vim.keymap.set({ "o", "x" }, "ag", "<cmd>lua require('various-textobjs').chainMember('outer')<cr>")
		end,
	},
	{
		"nikitarevenco/nvim-treesitter-textobjects",
		branch = "personal",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			textobjects = {
				move = {
					enable = true,
					goto_next_start = {
						["]a"] = "@parameter.inner",
						["]l"] = "@loop.outer",
						["]m"] = "@function.outer",
						["]c"] = "@conditional.outer",
						["]o"] = "@class.outer",
						["]f"] = "@call.outer",
						["]h"] = "@block.outer",
						["]i"] = "@assignment.outer",
						["]r"] = "@return.outer",
						["]n"] = "@annotation.outer",
					},
					goto_previous_start = {
						["[a"] = "@parameter.inner",
						["[l"] = "@loop.outer",
						["[m"] = "@function.outer",
						["[c"] = "@conditional.outer",
						["[o"] = "@class.outer",
						["[f"] = "@call.outer",
						["[h"] = "@block.outer",
						["[i"] = "@assignment.outer",
						["[r"] = "@return.outer",
						["[n"] = "@annotation.outer",
					},
				},
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["id"] = { query = "@number.inner", desc = "number" },
						["au"] = { query = "@statement.outer", desc = "statement" },
						["iu"] = { query = "@assignment.outer", desc = "assignment" },
            ["ah"] = { query = "@block.outer", desc = "block" },
            ["ih"] = { query = "@block.inner", desc = "block" },
            ["ao"] = { query = "@class.outer", desc = "class" },
            ["io"] = { query = "@class.inner", desc = "class" },
            ["ai"] = { query = "@assignment.lhs", desc = "assignment lhs" },
            ["ii"] = { query = "@assignment.rhs", desc = "assignment rhs" },
            ["in"] = { query = "@annotation.inner", desc = "annotation" },
            ["an"] = { query = "@annotation.outer", desc = "annotation" },
            ["af"] = { query = "@call.outer", desc = "function call" },
            ["if"] = { query = "@call.inner", desc = "function call" },
            ["ac"] = { query = "@conditional.outer", desc = "conditional" },
            ["ic"] = { query = "@conditional.inner", desc = "conditional" },
            ["ir"] = { query = "@return.inner", desc = "return" },
            ["ar"] = { query = "@return.outer", desc = "return" },
						["am"] = { query = "@function.outer", desc = "function" },
						["im"] = { query = "@function.inner", desc = "function" },
						["al"] = { query = "@loop.outer", desc = "loop" },
						["il"] = { query = "@loop.inner", desc = "loop" },
						["aa"] = { query = "@parameter.outer", desc = "argument" },
						["ia"] = { query = "@parameter.inner", desc = "argument" },
					},
				},
			},
		},
		config = function(_, opts)
			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
			require("nvim-treesitter.configs").setup(opts)
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
