--[[ vim: set filetype=lua : ]]

vim.o.autoindent = true
vim.o.background = "dark"
vim.o.backspace = "indent,eol,start"
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 0
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.laststatus = 0
vim.o.mouse = ""
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 2
vim.o.showtabline = 0
vim.o.sidescrolloff = 8
vim.o.signcolumn = "yes:1"
vim.o.smartcase = true
vim.o.smoothscroll = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.statusline = "%#CursorLineSign#%{repeat('─',winwidth('.'))}"
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 750
vim.o.wrap = true

vim.keymap.set("i", ",", ",<C-g>u", { desc = "add undo breakpoint" })
vim.keymap.set("i", ".", ".<C-g>u", { desc = "add undo breakpoint" })
vim.keymap.set("i", ";", ";<C-g>u", { desc = "add undo breakpoint" })
vim.keymap.set("n", "<bs>", "<cmd>edit #<cr>", { silent = true, desc = "alternate buffer" })
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "<right>", "<C-w>", { desc = "window commands" })
vim.keymap.set("n", "<space>x", "<cmd>qa!<cr>")
vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "exit terminal mode" })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "escape and clear hlsearch" })

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
			snippets = true,
			ts_context = true,
			virtual_text = true,
			cmp_border = true,
			highlight_symbol = true,
		},
		keys = {
			lsp = {
				hover_diagnostics = "<c-k>",
				code_action = "<nop>",
				goto_references = "<nop>",
				goto_implementation = "<nop>",
				outgoing_calls = "<nop>",
				incoming_calls = "<nop>",
				document_symbols = "<nop>",
				workspace_symbols = "<nop>",
			},
			typescript = {
				file_references = "<nop>",
				organize_imports = "<nop>",
				add_missing_imports = "<space>u",
				remove_unused_imports = "<space>y",
				fix_all = "<nop>",
			},
		},
	}),
	{
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		keys = {
			{ "<space>n", "<cmd>GrugFar<cr>", desc = "search and replace" },
			{
				"<space>.",
				"<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })<cr>",
				desc = "search and replace file",
			},
		},
		opts = {},
	},
	{
		"akinsho/toggleterm.nvim",
		opts = {
			open_mapping = "<space>e",
			insert_mappings = false,
			terminal_mappings = false,
			autochdir = true,
			shade_terminals = false,
			direction = "horizontal",
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
				"<space>i",
				"<cmd>Neogit<CR>",
				mode = "n",
				desc = "neogit",
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		cmd = "FzfLua",
		opts = { winopts = { border = "none", fullscreen = true } },
		keys = {
			{
				"grs",
				"<cmd>lua require('fzf-lua').lsp_workspace_symbols({ file_ignore_patterns = { '.contentlayer', '.next', '.expo' } })<cr>",
			},
			{ "<space>s", "<cmd>FzfLua grep_project<cr>", desc = "grep" },
			{ "<space>t", "<cmd>FzfLua files<cr>", desc = "files" },
			{ "<space>k", "<cmd>FzfLua oldfiles<cr>", desc = "old files" },
			{ "<space>g", "<cmd>FzfLua git_commits<cr>", desc = "project commits" },
			{ "<space>m", "<cmd>FzfLua git_bcommits<cr>", desc = "buffer commits" },
			{ "<space>o", "<cmd>FzfLua buffers<cr>", desc = "buffers" },
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
					gs = {
						callback = function()
							-- get the current directory
							local prefills = { paths = require("oil").get_current_dir() }

							local grug_far = require("grug-far")
							-- instance check
							if not grug_far.has_instance("explorer") then
								grug_far.open({
									instanceName = "explorer",
									prefills = prefills,
									staticTitle = "Find and Replace from Explorer",
								})
							else
								grug_far.open_instance("explorer")
								-- updating the prefills without clearing the search and other fields
								grug_far.update_instance_prefills("explorer", prefills, false)
							end
						end,
						desc = "Search in directory",
					},
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
				"<cmd>Oil<cr>",
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
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
			require("nvim-surround").buffer_setup({
				-- Surround with markdown link
				surrounds = {
					["l"] = {
						add = function()
							local clipboard = vim.fn.getreg("+"):gsub("\n", "")
							return {
								{ "[" },
								{ "](" .. clipboard .. ")" },
							}
						end,
						find = "%b[]%b()",
						delete = "^(%[)().-(%]%b())()$",
						change = {
							target = "^()()%b[]%((.-)()%)$",
							replacement = function()
								local clipboard = vim.fn.getreg("+"):gsub("\n", "")
								return {
									{ "" },
									{ clipboard },
								}
							end,
						},
					},
				},
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"chrisgrieser/nvim-spider",
		config = function()
			vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "forward" })
			vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "forward" })
			vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "backward" })
			vim.keymap.set(
				{ "n", "o", "x" },
				"ge",
				"<cmd>lua require('spider').motion('ge')<CR>",
				{ desc = "backward" }
			)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				vim.keymap.set("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { buffer = bufnr })

				vim.keymap.set("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { buffer = bufnr })
			end,
		},
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
			vim.cmd("colorscheme catppuccin")
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
