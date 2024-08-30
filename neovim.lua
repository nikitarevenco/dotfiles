local function is_os_windows()
	local path_separator = package.config:sub(1, 1)
	return path_separator == "\\"
end

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

local function exit_terminal_mode()
	if string.find(vim.api.nvim_buf_get_name(0), "lazygit") then
		return "<esc>"
	else
		return "<C-\\><C-n>"
	end
end

local function telescroll(prompt_bufnr, opts)
	local telescope_state = require("telescope.state")
	local telescope_action_state = require("telescope.actions.state")
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

local autocmd = vim.api.nvim_create_autocmd

vim.g.markdown_recommended_style = 0
vim.g.mapleader = " "
vim.o.updatetime = 750
vim.opt.showtabline = 0
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.scrolloff = 8
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
vim.opt.signcolumn = "yes"
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard:append("unnamedplus")
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false

local keymaps = {
	window_focus_left = "<leader>h",
	window_focus_right = "<leader>l",
	window_focus_above = "<leader>k",
	window_focus_below = "<leader>j",
	terminal_toggle_vertical = "<leader>an",
	git_blame_toggle = "<leader>rn",
	lazygit_file = "<leader>rt",
	window_quit = "<leader>so",
	window_close = "<leader>ss",
	window_split_vertically = "<leader>sm",
	info_toggle_conceal = "<leader>tr",
	spider_forward = "e",
	spider_backward = "m",
	lsp_hover = "<leader>tt",
	lsp_code_actions = "<leader>na",
	lsp_rename = "<leader>nr",
	dial_increment = "<leader>ns",
	ts_remove_unused_imports = "<leader>nn",
	ts_add_missing_imports = "<leader>np",
	buffers = "<leader>ea",
	recent_files = "<leader>ee",
	find_files = "<leader>ei",
	explorer_cwd = "<leader>eo",
	explorer_project = "<leader>et",
	symbols_project = "<leader>ia",
	grep_file = "<leader>ie",
	grep_cwd = "<leader>in",
	lsp_ts_goto_definition = "<leader>oa",
	lsp_goto_type_definition = "<leader>or",
	toggle_diagnostic_lines = "<leader>we",
	ts_rename_file = "<leader>uu",
	window_decrease_width = "<C-Left>",
	window_decrease_height = "<C-Down>",
	window_increase_width = "<C-Right>",
	window_increase_height = "<C-Up>",
	cmp_abort = "<C-e>",
	cmp_confirm = "<CR>",
	signature_help = "<c-s>",
	execute_normal_command = "<C-z>",
	code_action_delete_word = "<C-BS>",
	code_action_write_file = "<cr>",
	movement_page_down = "J",
	movement_page_up = "K",
	window_close_some_file_types = "q",
	window_previous_file = "<bs>",
	terminal_exit_terminal_mode = "<esc>",
}

local HIDDEN_KEYBIND = "which_key_ignore"

keybind("page down", keymaps.movement_page_down, "<C-d>", "n", { noremap = true, silent = true })
keybind("page up", keymaps.movement_page_up, "<C-u>", "n", { noremap = true, silent = true })
keybind(HIDDEN_KEYBIND, "j", "v:count == 0 ? 'gj' : 'j'", { "n", "x" }, { expr = true, silent = true })
keybind(HIDDEN_KEYBIND, "k", "v:count == 0 ? 'gk' : 'k'", { "n", "x" }, { expr = true, silent = true })
keybind(HIDDEN_KEYBIND, keymaps.execute_normal_command, "<C-o>", "i")
keybind("increase buffer height", keymaps.window_increase_height, "<cmd>resize +2<cr>")
keybind("increase buffer width", keymaps.window_increase_width, "<cmd>resize +2<cr>")
keybind("decrease buffer height", keymaps.window_decrease_height, "<cmd>resize +2<cr>")
keybind("decrease buffer width", keymaps.window_decrease_width, "<cmd>resize +2<cr>")
keybind("split buffer vertically", keymaps.window_split_vertically, "<C-w>s")
keybind("close buffer", keymaps.window_close, "<cmd>close<cr>")
keybind("quit neovim", keymaps.window_quit, "<cmd>qa!<cr>")
keybind("alternate buffer", keymaps.window_previous_file, "<cmd>edit #<cr>", "n", { silent = true })
keybind("focus buffer below", keymaps.window_focus_below, "<C-w>j", "n", { remap = true })
keybind("focus buffer above", keymaps.window_focus_above, "<C-w>k", "n", { remap = true })
keybind("focus buffer left", keymaps.window_focus_left, "<C-w>h", "n", { remap = true })
keybind("focus buffer right", keymaps.window_focus_right, "<C-w>l", "n", { remap = true })
keybind("toggle conceal", keymaps.info_toggle_conceal, toggle_conceal)
keybind("hover", keymaps.lsp_hover, vim.lsp.buf.hover)
keybind("format", keymaps.code_action_write_file, "<cmd>w<cr><esc>")
keybind(
	"leave terminal mode",
	keymaps.terminal_exit_terminal_mode,
	exit_terminal_mode,
	"t",
	{ expr = true, noremap = true, silent = true }
)
keybind("show signature", keymaps.signature_help, vim.lsp.buf.signature_help)

autocmd(
	{ "FocusLost", "ModeChanged", "TextChanged", "BufEnter" },
	{ desc = "autosave", pattern = "*", command = "silent! update" }
)
autocmd("BufReadPost", {
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
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	desc = "check if we need to reload the file when it changed",
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})
autocmd({ "VimResized" }, {
	desc = "resize splits if window got resized",
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})
autocmd("TextYankPost", {
	desc = "highlight on yank",
	callback = function()
		vim.highlight.on_yank()
	end,
})
autocmd("FileType", {
	desc = "close some file types with q",
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
		keybind(
			"close buffer",
			keymaps.window_close_some_file_types,
			"<cmd>close<cr>",
			"n",
			{ buffer = event.buf, silent = true }
		)
	end,
})

local plugin_ts_autotag = {
	"windwp/nvim-ts-autotag",
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
		})
	end,
}

local plugin_mdx = {
	"davidmh/mdx.nvim",
	config = true,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
}

local plugin_treesitter = {
	"nvim-treesitter/nvim-treesitter",
	cmd = { "TSInstall", "TSUpdate", "TSUpdateSync" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
			},
			indent = { enable = true },
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
}

local plugin_treesitter_textobjects = {
	"nvim-treesitter/nvim-treesitter-textobjects",
	config = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["ah"] = { query = "@assignment.outer", desc = "assignment" },
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
			},
		})
	end,
}

local plugin_various_textobjs = {
	"chrisgrieser/nvim-various-textobjs",
	config = function()
		local textobjs = require("various-textobjs")

		textobjs.setup({
			useDefaultKeymaps = false,
		})
		keybind("open url", "gx", function()
			textobjs.url()
			local foundURL = vim.fn.mode():find("v")
			if foundURL then
				vim.cmd.normal('"zy')
				local url = vim.fn.getreg("z")
				vim.ui.open(url)
			else
				local urlPattern = require("various-textobjs.charwise-textobjs").urlPattern
				local bufText = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
				local urls = {}
				for url in bufText:gmatch(urlPattern) do
					table.insert(urls, url)
				end
				if #urls == 0 then
					return
				end

				vim.ui.select(urls, { prompt = "Select URL:" }, function(choice)
					if choice then
						vim.ui.open(choice)
					end
				end)
			end
		end, "n")

		local opts = { "o", "x" }

		keybind("subword (inner)", "ir", function()
			textobjs.subword("inner")
		end, opts)

		keybind("subword (outer)", "ar", function()
			textobjs.subword("outer")
		end, opts)

		keybind("to next bracket", "(", function()
			textobjs.toNextClosingBracket()
		end, opts)

		keybind("to next quotation mark", '"', function()
			textobjs.toNextQuotationMark()
		end, opts)

		keybind("entire buffer", "A", function()
			textobjs.entireBuffer()
		end, opts)

		keybind("near end of line", "o", function()
			textobjs.nearEoL()
		end, opts)

		keybind("line characterwise (inner)", "n", function()
			textobjs.lineCharacterwise("inner")
		end, opts)

		keybind("markdown emphasis (inner)", "ij", function()
			textobjs.mdEmphasis("inner")
		end, opts)

		keybind("markdown emphasis (outer)", "aj", function()
			textobjs.mdEmphasis("outer")
		end, opts)

		keybind("markdown code (inner)", "ij", function()
			textobjs.mdFencedCodeBlock("inner")
		end, opts)

		keybind("markdown code (outer)", "aj", function()
			textobjs.mdFencedCodeBlock("outer")
		end, opts)

		keybind("tag attribute (inner)", "in", function()
			textobjs.htmlAttribute("inner")
		end, opts)

		keybind("tag attribute (outer)", "an", function()
			textobjs.htmlAttribute("outer")
		end, opts)

		keybind("value (inner)", "io", function()
			textobjs.value("inner")
		end, opts)

		keybind("value (outer)", "ao", function()
			textobjs.value("outer")
		end, opts)

		keybind("key (inner)", "ie", function()
			textobjs.key("inner")
		end, opts)

		keybind("key (outer)", "ae", function()
			textobjs.key("outer")
		end, opts)

		keybind("url", "u", function()
			textobjs.url()
		end, opts)

		keybind("chain (inner)", "ig", function()
			textobjs.chainMember("inner")
		end, opts)

		keybind("chain (outer)", "ag", function()
			textobjs.chainMember("outer")
		end, opts)
	end,
}

local plugin_cmp = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			opts = { updateevents = "TextChanged,TextChangedI" },
			keys = {},
		},
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
		{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
	},
	config = function()
		local cmp = require("cmp")
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			performance = {
				max_view_entries = 3,
			},
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},

			mapping = cmp.mapping.preset.insert({
				[keymaps.cmp_abort] = cmp.mapping.abort(),
				[keymaps.cmp_confirm] = cmp.mapping.confirm({ select = true }),
			}),

			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
					entry_filter = function(entry)
						return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
					end,
				},
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),

			formatting = {
				format = function(entry, item)
					item = require("lspkind").cmp_format({
						maxwidth = 50,
						ellipsis_char = "...",
					})(entry, item)

					return require("tailwindcss-colorizer-cmp").formatter(entry, item)
				end,
			},
		})
	end,
}

local plugin_mason_lspconfig = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup({
			ui = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
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
}

local plugin_helpview = {
	"OXY2DEV/helpview.nvim",
	lazy = false,
	ft = "help",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
}

local plugin_yazi = {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		{
			keymaps.explorer_cwd,
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		{
			keymaps.explorer_project,
			"<cmd>Yazi cwd<cr>",
			desc = "Open the file manager in nvim's working directory",
		},
		{
			"<c-up>",
			"<cmd>Yazi toggle<cr>",
			desc = "Resume the last yazi session",
		},
	},
	opts = {
		open_for_directories = true,
		keymaps = {
			show_help = "<f1>",
		},
	},
}

local plugin_lspconfig = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
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

		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				keybind("code actions", keymaps.lsp_code_actions, vim.lsp.buf.code_action, { "n", "v" }, opts)
				keybind("rename", keymaps.lsp_rename, vim.lsp.buf.rename, "n", opts)
				keybind("go to previous diagnostic", "[d", vim.diagnostic.goto_prev, "n", opts)
				keybind("go to next diagnostic", "]d", vim.diagnostic.goto_next, "n", opts)
				keybind("go to definition", keymaps.lsp_goto_definition, vim.lsp.buf.definition, "n", opts)
				keybind(
					"go to type definition",
					keymaps.lsp_goto_type_definition,
					vim.lsp.buf.type_definition,
					"n",
					opts
				)
				keybind("restart lsp", keymaps.lsp_restart, "<cmd>LspRestart<cr>", "n", opts)
				keybind("go to implementation", keymaps.lsp_goto_implementation, vim.lsp.buf.implementation, "n", opts)
				keybind("go to declaration", keymaps.lsp_goto_declaration, vim.lsp.buf.declaration, "n", opts)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		for type, icon in pairs({ Error = " ", Warn = " ", Hint = " ", Info = " " }) do
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
			["svelte"] = function()
				lspconfig["svelte"].setup({
					capabilities = capabilities,
					on_attach = function(client)
						autocmd("BufWritePost", {
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
}

local plugin_lint = {
	"mfussenegger/nvim-lint",
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

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}

local plugin_conform = {
	"stevearc/conform.nvim",
	lazy = false,
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
			async = false,
			timeout_ms = 1000,
		},
	},
}

local plugin_follow_md_links = {
	"jghauser/follow-md-links.nvim",
}

local plugin_autopairs = {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true,
			ts_config = {
				lua = { "string" },
				javascript = { "template_string" },
				java = false,
			},
		})

		require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
	end,
}

local plugin_comments = {
	"numToStr/Comment.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		local comment = require("Comment")

		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		comment.setup({
			pre_hook = ts_context_commentstring.create_pre_hook(),
		})
	end,
}

local plugin_substitute = {
	"gbprod/substitute.nvim",
	config = function()
		local substitute = require("substitute")
		substitute.setup()
	end,
	keys = {
		{ "s", "<cmd>lua require('substitute').operator()<cr>", desc = "substitute with motion" },
		{ "ss", "<cmd>lua require('substitute').line()<cr>", desc = "substitute line" },
		{ "S", "<cmd>lua require('substitute').eol()<cr>", desc = "substitute until end of line" },
		{ "s", "<cmd>lua require('substitute').visual()<cr>", desc = "substitute visual", mode = "x" },
	},
}

local plugin_surround = {
	"kylechui/nvim-surround",
	config = true,
}

local plugin_dial = {
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
			keymaps.dial_increment,
			function()
				require("dial.map").manipulate("increment", "normal")
			end,
			desc = "cycle",
		},
	},
}

local plugin_lsp_lines = {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	lazy = false,
	config = function()
		require("lsp_lines").setup()
		vim.diagnostic.config({
			virtual_text = false,
		})
		vim.diagnostic.config({ virtual_lines = false }, require("lazy.core.config").ns)

		vim.diagnostic.config({ virtual_lines = false })
	end,
	keys = {
		{
			keymaps.toggle_diagnostic_lines,
			'<cmd>lua require("lsp_lines").toggle()<CR>',
			mode = "n",
			desc = "toggle line diagnostics",
		},
	},
}

local plugin_telescope = {
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
			"project",
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
			keymaps.grep_cwd,
			"<cmd>Telescope live_grep<CR>",
			mode = "n",
			desc = "grep in current directory",
		},
		{
			keymaps.grep_file,
			"<cmd>Telescope current_buffer_fuzzy_find<CR>",
			mode = "n",
			desc = "grep in document",
		},
		{
			keymaps.recent_files,
			"<cmd>Telescope oldfiles<CR>",
			mode = "n",
			desc = "recent files",
		},
		{
			keymaps.find_files,
			"<cmd>Telescope find_files<CR>",
			mode = "n",
			desc = "find files (cwd)",
		},
		{
			keymaps.symbols_project,
			"<cmd>Telescope lsp_workspace_symbols<CR>",
			mode = "n",
			desc = "workspace symbols (telescope)",
		},
		{
			keymaps.buffers,
			"<cmd>Telescope buffers<CR>",
			mode = "n",
			desc = "Buffers (telescope)",
		},
	},
}

local plugin_spider = {
	"chrisgrieser/nvim-spider",
	config = function()
		keybind(HIDDEN_KEYBIND, keymaps.spider_forward, "<cmd>lua require('spider').motion('w')<CR>", { "n", "o", "x" })
		keybind(
			HIDDEN_KEYBIND,
			keymaps.spider_backward,
			"<cmd>lua require('spider').motion('b')<CR>",
			{ "n", "o", "x" }
		)
	end,
}

local plugin_numb = {
	"nacro90/numb.nvim",
	opts = {},
}

local plugin_lazygit = {
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
			keymaps.lazygit_file,
			"<cmd>LazyGitCurrentFile<cr>",
			desc = "git manager (file)",
		},
	},
}

local plugin_rainbow_delimiters = {
	"HiPhish/rainbow-delimiters.nvim",
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
}

local plugin_colorizer = {
	"NvChad/nvim-colorizer.lua",
	opts = {
		user_default_options = {
			tailwind = true,
			css = true,
			RRGGBBAA = true,
			AARRGGBB = true,
		},
	},
}

local plugin_gitsigns = {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup()
	end,
}

local plugin_lualine = {
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
}

local plugin_catppuccin = {
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
}

local plugin_toggleterm = {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			open_mapping = keymaps.terminal_toggle_vertical,
			insert_mappings = false,
			terminal_mappings = false,
			autochdir = true,
			size = vim.o.columns * 0.5,
			direction = "vertical",
			shell = function()
				if is_os_windows() then
					return 'cmd.exe /s /k "clink inject -q && %userprofile%\\dotfiles\\doskeys.cmd"'
				end
			end,
		})
	end,
}

local plugin_indent_blankline = {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = { char = "┊" },
	},
}

local plugin_typescript_tools = {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {},
	config = function()
		require("typescript-tools").setup({})
		keybind("ts rename file", keymaps.ts_rename_file, "<cmd>TSToolsRenameFile<cr>")
		keybind("ts go to source definition", keymaps.lsp_ts_goto_definition, "<cmd>TSToolsGoToSourceDefinition<cr>")
		keybind("ts add missing imports", keymaps.ts_add_missing_imports, "<cmd>TSToolsAddMissingImports<cr>")
		keybind("ts remove unused imports", keymaps.ts_remove_unused_imports, "<cmd>TSToolsRemoveUnusedImports<cr>")
	end,
}

local plugin_which_key = {
	"folke/which-key.nvim",
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
		icons = {
			breadcrumb = "➜",
			separator = "...",
			group = "",
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		vim.o.timeout = true
		vim.o.timeoutlen = 300
		wk.setup(opts)
		wk.register({
			["<leader>"] = {
				["<leader>"] = { "macro" },
				name = "command",
				a = { name = "terminal" },
				e = { name = "explorer" },
				o = { name = "goto" },
				i = { name = "find" },
				m = {
					name = "debug",
				},
				g = { name = "test" },
				f = { name = "docs" },
				w = { name = "diagnostic" },
				s = { name = "window" },
				n = { name = "action" },
				t = { name = "info" },
				u = { name = "file" },
				r = { name = "git" },
				z = {
					name = "command",
				},
			},
			["["] = { name = "last" },
			["!"] = { name = "filter" },
			["]"] = { name = "next" },
			["<CR>"] = { desc = "quick open" },
			["<C-h>"] = { desc = HIDDEN_KEYBIND },
			["<C-k>"] = { desc = HIDDEN_KEYBIND },
			["<C-Bslash>"] = { desc = HIDDEN_KEYBIND },
			["<C-j>"] = { desc = HIDDEN_KEYBIND },
			["<C-l>"] = { desc = HIDDEN_KEYBIND },
			["<"] = { name = "indent-left" },
			["&"] = { name = HIDDEN_KEYBIND },
			[";"] = { name = HIDDEN_KEYBIND },
			[","] = { name = HIDDEN_KEYBIND },
			["%"] = { name = HIDDEN_KEYBIND },
			[">"] = { name = "indent-right" },
			k = { name = "filter" },
			Y = { desc = HIDDEN_KEYBIND },
			S = { desc = HIDDEN_KEYBIND },
			K = { name = HIDDEN_KEYBIND },
			t = { desc = HIDDEN_KEYBIND },
			T = { desc = HIDDEN_KEYBIND },
			s = { name = "substitute", mode = { "o", "x", "n", "v" } },
			f = { desc = HIDDEN_KEYBIND },
			F = { desc = HIDDEN_KEYBIND },
			y = { name = "yank" },
			v = { name = "visual" },
			z = { name = "fold" },
			d = { name = "delete" },
			c = { name = "change" },
			g = { name = "goto" },
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
}

local plugin_noice = {
	"folke/noice.nvim",
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
}

local plugins_meta = {
	["windwp/nvim-ts-autotag"] = { true, "323a3e16ed603e2e17b26b1c836d1e86c279f726", plugin_ts_autotag },
	["davidmh/mdx.nvim"] = { true, "61b93f6576cb5229020723c7a81f5a01d2667d05", plugin_mdx },
	["nvim-treesitter/nvim-treesitter"] = { true, "585860a1865853d2c287c8ef534297da8115818e", plugin_treesitter },
	["nvim-treesitter/nvim-treesitter-textobjects"] = {
		true,
		"41e3abf6bfd9a9a681eb1f788bdeba91c9004b2b",
		plugin_treesitter_textobjects,
	},
	["chrisgrieser/nvim-various-textobjs"] = {
		true,
		"8dbc655f794202f45ab6a1cac1cb323a218ac6a1",
		plugin_various_textobjs,
	},
	["hrsh7th/nvim-cmp"] = { true, "ae644feb7b67bf1ce4260c231d1d4300b19c6f30", plugin_cmp },
	["williamboman/mason-lspconfig.nvim"] = { true, "482350b050bd413931c2cdd4857443c3da7d57cb", plugin_mason_lspconfig },
	["OXY2DEV/helpview.nvim"] = { true, "857aec1dab331252910da158ab6cbfbc65239c71", plugin_helpview },
	["mikavilpas/yazi.nvim"] = { true, "a82ccb33ffe139415285946a5154907c3f1db1dd", plugin_yazi },
	["neovim/nvim-lspconfig"] = { true, "6bfd9210e312af6cfedba05d272e85618c93ab0d", plugin_lspconfig },
	["mfussenegger/nvim-lint"] = { true, "debabca63c0905b59ce596a55a8e33eafdf66342", plugin_lint },
	["stevearc/conform.nvim"] = { true, "62eba813b7501b39612146cbf29cd07f1d4ac29c", plugin_conform },
	["jghauser/follow-md-links.nvim"] = { true, "caa85cad973c5e612662d04b55e07eefc88f1d6b", plugin_follow_md_links },
	["windwp/nvim-autopairs"] = { true, "19606af7c039271d5aa96bceff101e7523af3136", plugin_autopairs },
	["numToStr/Comment.nvim"] = { true, "e30b7f2008e52442154b66f7c519bfd2f1e32acb", plugin_comments },
	["gbprod/substitute.nvim"] = { true, "97f49d16f8eea7967d41db4f657dd63af53eeba1", plugin_substitute },
	["kylechui/nvim-surround"] = { true, "ec2dc7671067e0086cdf29c2f5df2dd909d5f71f", plugin_surround },
	["https://git.sr.ht/~whynothugo/lsp_lines.nvim"] = {
		true,
		"7d9e2748b61bff6ebba6e30adbc7173ccf21c055",
		plugin_lsp_lines,
	},
	["nvim-telescope/telescope.nvim"] = { true, "5972437de807c3bc101565175da66a1aa4f8707a", plugin_telescope },
	["chrisgrieser/nvim-spider"] = { true, "7641ce03636633b986493fc6f52d5051cb1375ce", plugin_spider },
	["nacro90/numb.nvim"] = { true, "3f7d4a74bd456e747a1278ea1672b26116e0824d", plugin_numb },
	["HiPhish/rainbow-delimiters.nvim"] = {
		true,
		"9f3d10e66a79e8975926f8cb930856e4930d9da4",
		plugin_rainbow_delimiters,
	},
	["NvChad/nvim-colorizer.lua"] = { true, "194ec600488f7c7229668d0e80bd197f3a2b84ff", plugin_colorizer },
	["lewis6991/gitsigns.nvim"] = { true, "899e993850084ea33d001ec229d237bc020c19ae", plugin_gitsigns },
	["nvim-lualine/lualine.nvim"] = { true, "b431d228b7bbcdaea818bdc3e25b8cdbe861f056", plugin_lualine },
	["catppuccin/nvim"] = { true, "4fd72a9ab64b393c2c22b168508fd244877fec96", plugin_catppuccin },
	["monaqa/dial.nvim"] = { true, "ed4d6a5bbd5e479b4c4a3019d148561a2e6c1490", plugin_dial },
	["lukas-reineke/indent-blankline.nvim"] = {
		true,
		"db926997af951da38e5004ec7b9fbdc480b48f5d",
		plugin_indent_blankline,
	},
	["pmizio/typescript-tools.nvim"] = { true, "f8c2e0b36b651c85f52ad5c5373ff8b07adc15a7", plugin_typescript_tools },
	["folke/which-key.nvim"] = { true, "0539da005b98b02cf730c1d9da82b8e8edb1c2d2", plugin_which_key },
	["kdheepak/lazygit.nvim"] = { true, "2432b447483f42ff2e18b2d392cb2bb27e495c08", plugin_lazygit },
	["folke/noice.nvim"] = { true, "448bb9c524a7601035449210838e374a30153172", plugin_noice },
	["akinsho/toggleterm.nvim"] = { true, "137d06fb103952a0fb567882bb8527e2f92d327d", plugin_toggleterm },
}

local plugins = {}

for plugin_name, plugin_settings in pairs(plugins_meta) do
	local config = plugin_settings[3]

	config[1] = plugin_name
	config.cond = plugin_settings[1]
	config.commit = plugin_settings[2]
	config.event = config.event or { "BufReadPre", "BufNewFile", "BufWritePre" }

	table.insert(plugins, config)
end

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

require("lazy").setup(plugins, lazy_options)
