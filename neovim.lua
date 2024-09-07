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

local function toggle_line_numbers()
	if vim.wo.number then
		vim.wo.number = false
		vim.wo.relativenumber = false
	else
		vim.wo.number = true
		vim.wo.relativenumber = true
	end
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

local autocmd = vim.api.nvim_create_autocmd

vim.g.markdown_recommended_style = 0
vim.g.mapleader = " "
vim.o.updatetime = 750
vim.opt.showtabline = 0
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
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard:append("unnamedplus")
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.shortmess:append("I")
vim.wo.number = false
vim.wo.relativenumber = false
vim.o.laststatus = 0
vim.cmd("hi! link StatusLine Normal")
vim.cmd("hi! link StatusLineNC Normal")
vim.cmd("set statusline=%{repeat('─',winwidth('.'))}")
vim.wo.signcolumn = "yes:1"

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
	lsp_goto_definition = "<leader>os",
	lsp_goto_type_definition = "<leader>or",
	toggle_diagnostic_lines = "<leader>we",
	ts_rename_file = "<leader>uu",
	toggle_line_numbers = "<leader>z",
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

keybind("toggle left panel", keymaps.toggle_line_numbers, toggle_line_numbers, "n")
keybind("page down", keymaps.movement_page_down, "<C-d>", "n", { noremap = true, silent = true })
keybind("page up", keymaps.movement_page_up, "<C-u>", "n", { noremap = true, silent = true })
keybind("move up", "j", "v:count == 0 ? 'gj' : 'j'", { "n", "x" }, { expr = true, silent = true })
keybind("move down", "k", "v:count == 0 ? 'gk' : 'k'", { "n", "x" }, { expr = true, silent = true })
keybind("execute normal command", keymaps.execute_normal_command, "<C-o>", "i")
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
keybind("format", keymaps.code_action_write_file, "<cmd>w<cr>")
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

local plugins = {
	{
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
	},
	{
		"nikitarevenco/nvim-treesitter-textobjects",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["r"] = { query = "@assignment.outer", desc = "assignment" },
							["as"] = { query = "@assignment.lhs", desc = "assignment lhs" },
							["is"] = { query = "@assignment.rhs", desc = "assignment rhs" },
							["ih"] = { query = "@return.inner", desc = "return" },
							["ah"] = { query = "@return.outer", desc = "return" },
							["ac"] = { query = "@block.outer", desc = "block" },
							["ic"] = { query = "@block.inner", desc = "block" },
							["af"] = { query = "@call.outer", desc = "function call" },
							["if"] = { query = "@call.inner", desc = "function call" },
							["aC"] = { query = "@class.outer", desc = "class" },
							["iC"] = { query = "@class.inner", desc = "class" },
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
			})
		end,
	},
	{
		"davidmh/mdx.nvim",
		config = true,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		config = function()
			local textobjs = require("various-textobjs")

			textobjs.setup({
				useDefaultKeymaps = false,
			})
			local opts = { "o", "x" }

			keybind("subword", "ir", function()
				textobjs.subword("inner")
			end, opts)

			keybind("subword", "ar", function()
				textobjs.subword("outer")
			end, opts)

			keybind("to next bracket", "(", function()
				textobjs.toNextClosingBracket()
			end, opts)

			keybind("to next quotation mark", '"', function()
				textobjs.toNextQuotationMark()
			end, opts)

			keybind("file", "A", function()
				textobjs.entireBuffer()
			end, opts)

			keybind("near end of line", "o", function()
				textobjs.nearEoL()
			end, opts)

			keybind("line characterwise", "n", function()
				textobjs.lineCharacterwise("inner")
			end, opts)

			keybind("attribute", "in", function()
				textobjs.htmlAttribute("inner")
			end, opts)

			keybind("attribute", "an", function()
				textobjs.htmlAttribute("outer")
			end, opts)

			keybind("value", "io", function()
				textobjs.value("inner")
			end, opts)

			keybind("value", "ao", function()
				textobjs.value("outer")
			end, opts)

			keybind("key", "ie", function()
				textobjs.key("inner")
			end, opts)

			keybind("key", "ae", function()
				textobjs.key("outer")
			end, opts)

			keybind("url", "u", function()
				textobjs.url()
			end, opts)

			keybind("chain", "ig", function()
				textobjs.chainMember("inner")
			end, opts)

			keybind("chain", "ag", function()
				textobjs.chainMember("outer")
			end, opts)
		end,
	},
	{
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
					"julials",
					"tailwindcss",
					"bashls",
					"mdx_analyzer",
					"gopls",
					"powershell_es",
					"nimls",
					"svelte",
					"lua_ls",
					"jsonls",
					"yamlls",
					"graphql",
					"emmet_ls",
					"prismals",
					"pyright",
					"taplo",
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettierd",
					"stylua",
					"isort",
					"ruff",
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
		lazy = false,
		ft = "help",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
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
			floating_window_scaling_factor = 1,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"b0o/schemastore.nvim",
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
				["yamlls"] = function()
					lspconfig["yamlls"].setup({
						settings = {
							yaml = {
								schemaStore = {
									enable = false,
									url = "",
								},
								schemas = require("schemastore").yaml.schemas(),
							},
						},
					})
				end,
				["jsonls"] = function()
					lspconfig["jsonls"].setup({
						settings = {
							json = {
								schemas = require("schemastore").json.schemas(),
								validate = { enable = true },
							},
						},
					})
				end,
				["ruff"] = function()
					lspconfig["ruff"].setup({
						settings = {
							organizeImports = false,
						},
						on_attach = function(client)
							client.server_capabilities.hoverProvider = false
						end,
					})
				end,
				["julials"] = function()
					lspconfig["julials"].setup({
						on_new_config = function(new_config, _)
							local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
							if require("lspconfig").util.path.is_file(julia) then
								vim.notify("Hello!")
								new_config.cmd[1] = julia
							end
						end,
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
				["powershell_es"] = function()
					lspconfig["powershell_es"].setup({
						filetypes = { "ps1", "psm1", "psd1" },
						capabilities = capabilities,
						bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
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
					require("lspconfig").lua_ls.setup({
						on_init = function(client)
							local path = client.workspace_folders[1].name
							if
								vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc")
							then
								return
							end
							client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
								runtime = {
									-- Tell the language server which version of Lua you're using
									-- (most likely LuaJIT in the case of Neovim)
									version = "LuaJIT",
								},
								-- Make the server aware of Neovim runtime files
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
										-- Depending on the usage, you might want to add additional paths here.
										"${3rd}/luv/library",
										-- "${3rd}/busted/library",
									},
									-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
									-- library = vim.api.nvim_get_runtime_file("", true)
								},
							})
						end,
						settings = {
							Lua = {},
						},
					})
				end,
			})
		end,
	},
	{
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
	},
	{
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
				md = { "prettierd" },
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
	},
	{
		"jghauser/follow-md-links.nvim",
	},
	{
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
	},
	{
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
	},
	{
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
	},
	{
		"kylechui/nvim-surround",
		config = true,
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
				keymaps.dial_increment,
				function()
					require("dial.map").manipulate("increment", "normal")
				end,
				desc = "cycle",
			},
		},
	},
	{
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
	},
	{
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
				},
			})

			local extensions = {
				"fzf",
				"project",
				"heading",
				"undo",
				"import",
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
	},
	{
		"chrisgrieser/nvim-spider",
		config = function()
			keybind(
				HIDDEN_KEYBIND,
				keymaps.spider_forward,
				"<cmd>lua require('spider').motion('w')<CR>",
				{ "n", "o", "x" }
			)
			keybind(
				HIDDEN_KEYBIND,
				keymaps.spider_backward,
				"<cmd>lua require('spider').motion('b')<CR>",
				{ "n", "o", "x" }
			)
		end,
	},
	{
		"nacro90/numb.nvim",
		opts = {},
	},
	{
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
	},
	{
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
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"catppuccin/nvim",
		opts = {
			integrations = {
				neotest = true,
				noice = true,
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
	},
	{
		"lukas-reineke/indent-blankline.nvim",
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
			keybind("ts rename file", keymaps.ts_rename_file, "<cmd>TSToolsRenameFile<cr>")
			keybind(
				"ts go to source definition",
				keymaps.lsp_ts_goto_definition,
				"<cmd>TSToolsGoToSourceDefinition<cr>"
			)
			keybind("ts add missing imports", keymaps.ts_add_missing_imports, "<cmd>TSToolsAddMissingImports<cr>")
			keybind("ts remove unused imports", keymaps.ts_remove_unused_imports, "<cmd>TSToolsRemoveUnusedImports<cr>")
		end,
	},
	{
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
	},
}

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
