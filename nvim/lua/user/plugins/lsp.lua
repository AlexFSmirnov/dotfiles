local function lsp_keymaps(bufnr)
	local buf_map = function(mode, lhs, rhs, desc)
		local opts = { noremap = true, silent = true, desc = desc }
		vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
	end

	buf_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Documentation")
	buf_map("n", "E", "<cmd>lua vim.diagnostic.open_float()<CR>", "Open diagnostic")

	buf_map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition")
	buf_map("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition")
	buf_map("n", "gi", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition")
	buf_map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration")
	buf_map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "Goto References")
end

return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"b0o/schemastore.nvim",
		},
		config = function()
			-- lsp_zero defaults ----------------------------------------------------
			local lsp_zero = require("lsp-zero")

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			lsp_zero.extend_lspconfig({
				capabilities = capabilities,
			})

			lsp_zero.on_attach(function(_client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
				lsp_keymaps(bufnr)
			end)

			lsp_zero.set_preferences({
				suggest_lsp_servers = true,
			})

			-- mason ----------------------------------------------------------------
			local lspconfig = require("lspconfig")
			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettierd",
					"stylua",
				},
			})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"tsserver",
					"basedpyright",
					"eslint@4.8.0",
					"jsonls",
					"cssls",
					"vimls",
				},
				handlers = {
					lsp_zero.default_setup,

					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim", "custom_nvim" },
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
									hint = { enable = true },
									telemetry = { enable = false },
								},
							},
						},
					}),

					lspconfig.jsonls.setup({
						settings = {
							json = {
								schemas = require("schemastore").json.schemas({
									select = {
										"package.json",
									},
								}),
								validate = { enable = true },
							},
						},
					}),

					lspconfig.tsserver.setup({
						root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
						filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
						cmd = { "typescript-language-server", "--stdio" },
					}),

					lspconfig.eslint.setup({
						filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
						settings = {
							workingDirectory = {
								mode = "auto",
							},
							format = { enable = true },
							lint = { enable = true },
						},
					}),
				},
			})

			-- Set up sign icons for diagnostics
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- Diagnostic config
			local config = {
				virtual_text = true,
				signs = true,
				update_in_insert = true,
				underline = false,

				severity_sort = true,
				float = {
					focusable = true,
					source = "always",
					style = "minimal",
					border = {
						{ "╭", "WinSeparator" },
						{ "─", "WinSeparator" },
						{ "╮", "WinSeparator" },
						{ "│", "WinSeparator" },
						{ "╯", "WinSeparator" },
						{ "─", "WinSeparator" },
						{ "╰", "WinSeparator" },
						{ "│", "WinSeparator" },
					},
					header = "",
					prefix = "",
				},
			}
			vim.diagnostic.config(config)
		end,
	},
	{
		"mhartington/formatter.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		event = "VeryLazy",
		opts = function()
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				command = "Format",
			})

			return {
				filetype = {
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
					json = {
						require("formatter.filetypes.json").prettierd,
					},
					javascript = {
						require("formatter.filetypes.javascript").prettierd,
					},
					javascriptreact = {
						require("formatter.filetypes.javascriptreact").prettierd,
					},
					typescript = {
						require("formatter.filetypes.typescript").prettierd,
					},
					typescriptreact = {
						require("formatter.filetypes.typescriptreact").prettierd,
					},
					["*"] = {
						require("formatter.filetypes.any").remove_trailing_whitespace,
					},
				},
			}
		end,
	},
}
