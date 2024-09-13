local function keybind(description, shortcut, action, modes, opts)
	local new_modes = modes or "n"
	local new_opts = opts or {}
	new_opts.desc = description

	vim.keymap.set(new_modes, shortcut, action, new_opts)
end

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
vim.keymap.set("n", "<leader>z", "<cmd>lua vim.wo.number = not vim.wo.number<cr>", { desc = "toggle left panel" })
vim.keymap.set("i", "<c-z>", "<C-o>", { desc = "execute normal command" })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "escape and clear hlsearch" })
vim.keymap.set("n", "<bs>", "<cmd>edit #<cr>", { silent = true, desc = "alternate buffer" })
vim.keymap.set("n", "<leader>b", toggle_conceal, { desc = "toggle conceal" })
vim.keymap.set("n", "<c-f>", "<cmd>w<cr>", { desc = "format" })
vim.keymap.set("t", "<esc>", "<cmd>ToggleTerm<cr>", { desc = "exit terminal mode" })
vim.keymap.set("i", "<C-d>", "<C-o><cmd>d<CR>", { desc = "delete line" })
vim.keymap.set("i", "<C-v>", "<esc>pa", { desc = "paste" })
vim.keymap.set("n", "gO", "<cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = "empty line below" })
vim.keymap.set("n", "go", "<cmd>call append(line('.'), repeat([''], v:count1))<CR>", { desc = "add empty line above" })
vim.keymap.set("x", "g/", "<esc>/\\%V", { silent = false, desc = "search inside visual selection" })
vim.keymap.set("n", "<right>", "<C-w>", { desc = "window commands" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "join line but keep cursor position" })

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

-- local instant_lsp_path = vim.fn.stdpath("data") .. "/instant-lsp.nvim"
-- if not vim.loop.fs_stat(instant_lsp_path) then
-- 	vim.fn.system({
-- 		"git",
-- 		"clone",
-- 		"--filter=blob:none",
-- 		"https://github.com/nikitarevenco/instant-lsp.nvim",
-- 		instant_lsp_path,
-- 	})
-- end
-- vim.opt.rtp:prepend(instant_lsp_path)

vim.opt.rtp:prepend("C:\\Users\\micro\\repos\\instant-lsp.nvim")

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
		languages = { "lua" },
		disable_feature = {
			snippets = true,
			ts_context = true,
			cmp_border = true,
		},
	}),
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
						["]i"] = "@conditional.outer",
						["]k"] = "@class.outer",
						["]f"] = "@call.outer",
						["]c"] = "@block.outer",
						["]T"] = "@assignment.outer",
						["]h"] = "@return.outer",
						["]o"] = "@annotation.outer",
						["]O"] = "@annotation.outer",
					},
					goto_previous_start = {
						["[a"] = "@parameter.inner",
						["[l"] = "@loop.outer",
						["[m"] = "@function.outer",
						["[i"] = "@conditional.outer",
						["[k"] = "@class.outer",
						["[f"] = "@call.outer",
						["[c"] = "@block.outer",
						["[T"] = "@assignment.outer",
						["[h"] = "@return.outer",
						["[o"] = "@annotation.outer",
						["[O"] = "@annotation.outer",
					},
				},
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["T"] = { query = "@assignment.outer", desc = "assignment" },
						["O"] = { query = "@statement.outer", desc = "statement" },
						["io"] = { query = "@annotation.inner", desc = "type annotation" },
						["ao"] = { query = "@annotation.outer", desc = "type annotation" },
						["ih"] = { query = "@return.inner", desc = "return" },
						["ah"] = { query = "@return.outer", desc = "return" },
						["as"] = { query = "@assignment.lhs", desc = "assignment lhs" },
						["is"] = { query = "@assignment.rhs", desc = "assignment rhs" },
						["ac"] = { query = "@block.outer", desc = "block" },
						["ic"] = { query = "@block.inner", desc = "block" },
						["af"] = { query = "@call.outer", desc = "function call" },
						["if"] = { query = "@call.inner", desc = "function call" },
						["ak"] = { query = "@class.outer", desc = "class" },
						["ik"] = { query = "@class.inner", desc = "class" },
						["ai"] = { query = "@conditional.outer", desc = "conditional" },
						["ii"] = { query = "@conditional.inner", desc = "conditional" },
						["am"] = { query = "@function.outer", desc = "function" },
						["im"] = { query = "@function.inner", desc = "function" },
						["al"] = { query = "@loop.outer", desc = "loop" },
						["il"] = { query = "@loop.inner", desc = "loop" },
						["N"] = { query = "@number.inner", desc = "number" },
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

			vim.keymap.set({ "o", "x" }, "ir", "<cmd>lua require('various-textobjs').subword('inner')<cr>")
			vim.keymap.set({ "o", "x" }, "ar", "<cmd>lua require('various-textobjs').subword('outer')<cr>")
			vim.keymap.set({ "o", "x" }, "A", "<cmd>lua require('various-textobjs').entireBuffer()<cr>")
			vim.keymap.set({ "o", "x" }, "o", "<cmd>lua require('various-textobjs').nearEoL()<cr>")
			vim.keymap.set({ "o", "x" }, "n", "<cmd>lua require('various-textobjs').lineCharacterwise('inner')<cr>")
			vim.keymap.set({ "o", "x" }, "iv", "<cmd>lua require('various-textobjs').value('inner')<cr>")
			vim.keymap.set({ "o", "x" }, "av", "<cmd>lua require('various-textobjs').value('outer')<cr>")
			vim.keymap.set({ "o", "x" }, "ik", "<cmd>lua require('various-textobjs').key('inner')<cr>")
			vim.keymap.set({ "o", "x" }, "ak", "<cmd>lua require('various-textobjs').key('outer')<cr>")
			vim.keymap.set({ "o", "x" }, "U", "<cmd>lua require('various-textobjs').url()<cr>", { desc = "url" })
			vim.keymap.set({ "o", "x" }, "ie", "<cmd>lua require('various-textobjs').chainMember('inner')<cr>")
			vim.keymap.set({ "o", "x" }, "ae", "<cmd>lua require('various-textobjs').chainMember('outer')<cr>")
		end,
	},
	{
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		opts = {},
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		opts = {
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			keymaps = {
				["<left>"] = "actions.parent",
				["<right>"] = "actions.select",
				["<esc>"] = "actions.close",
				["<leader>"] = { callback = ":w" },
			},
			view_options = {
				is_always_hidden = function(name)
					return name == ".."
				end,
				sort = {
					{ "mtime", "desc" },
				},
			},
		},
		keys = {
			{ "<leader>n", "<cmd>Oil<cr>", desc = "file manager" },
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
			"ibhagwan/fzf-lua",
		},
		opts = {
			disable_hint = true,
			graph_style = "unicode",
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
		"monaqa/dial.nvim",
		config = function()
			local create = require("dial.augend").constant.new
			require("dial.config").augends:register_group({
				default = {
					create({ elements = { "let", "const" } }),
					create({ elements = { "True", "False" } }),
					create({ elements = { "||", "&&" }, word = false }),
					create({ elements = { "true", "false" } }),
					create({ elements = { "and", "or" } }),
					create({ elements = { "===", "!==" }, word = false }),
					create({ elements = { "==", "!=" }, word = false }),
					create({ elements = { "- [ ]", "- [x]" }, word = false }),
				},
			})
		end,
		keys = {
			{
				"<leader>ns",
				function()
					require("dial.map").manipulate("increment", "normal")
				end,
				desc = "cycle",
			},
		},
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
		"samjwill/nvim-unception",
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
