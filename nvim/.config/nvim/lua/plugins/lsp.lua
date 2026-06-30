return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {
					registries = {
						"github:mason-org/mason-registry",
						"github:Crashdummyy/mason-registry",
					},
				},
			},
			"saghen/blink.cmp",
			"folke/lazydev.nvim",
		},
		opts = {
			servers = {
				lua_ls = {
					root_dir = function(bufnr, on_dir)
						on_dir(require("lazydev").find_workspace(bufnr))
					end,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								callSnippet = "Replace",
							},
							doc = {
								privateName = { "^_" },
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
						},
					},
				},
				vtsls = {
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					settings = {
						vtsls = {
							enableMoveToFileCodeAction = true,
							autoUseWorkspaceTsdk = true,
							experimental = {
								maxInlayHintLength = 30,
								completion = {
									enableServerSideFuzzyMatch = true,
								},
							},
							tsserver = {
								globalPlugins = {
									{
										name = "typescript-svelte-plugin",
										location = vim.fn.stdpath("data")
											.. "/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin",
										enableForWorkspaceTypeScriptVersions = true,
									},
								},
							},
						},
						typescript = {
							updateImportsOnFileMove = { enabled = "always" },
							suggest = {
								completeFunctionCalls = true,
							},
							inlayHints = {
								enumMemberValues = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								variableTypes = { enabled = false },
							},
						},
					},
				},
				ruff = {
					cmd_env = { RUFF_TRACE = "messages" },
					init_options = {
						settings = {
							logLevel = "error",
						},
					},
					on_attach = function()
						vim.keymap.set("n", "<leader>co", function()
							vim.lsp.buf.code_action({
								apply = true,
								context = {
									only = { "source.organizeImports" },
									diagnostics = {},
								},
							})
						end, { desc = "Organize Imports" })
					end,
				},
				basedpyright = {
					settings = {
						basedpyright = {
							analysis = {
								typecheckingmode = "off",
							},
						},
					},
				},
				gopls = {
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
							staticcheck = true,
							directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
							semanticTokens = true,
						},
					},
				},
				dockerls = {},
				docker_compose_language_service = {},
				cssls = {},
				html = {},
				ocamllsp = {},
				clangd = {},
				neocmake = {},
				rust_analyzer = {},
				wgsl_analyzer = {},
				tinymist = {},
				svelte = {},
				elixirls = {},
			},
		},
		config = function(_, opts)
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				},
				virtual_text = {
					source = "if_many",
					spacing = 2,
				},
			})

			vim.lsp.config("*", {
				---@param client vim.lsp.Client
				on_attach = function(client, bufnr)
					-- Setup inlay hints
					if client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end
				end,
			})

			for name, server_opts in pairs(opts.servers) do
				vim.lsp.config(name, server_opts)
				vim.lsp.enable(name)
			end
		end,
		keys = {
			{
				"]d",
				function()
					vim.diagnostic.jump({ count = 1 })
				end,
				desc = "Next diagnostic",
			},
			{
				"[d",
				function()
					vim.diagnostic.jump({ count = -1 })
				end,
				desc = "Previous diagnostic",
			},
			{
				"]e",
				function()
					vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
				end,
				desc = "Next error",
			},
			{
				"[e",
				function()
					vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
				end,
				desc = "Previous error",
			},
			{
				"]w",
				function()
					vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
				end,
				desc = "Next warning",
			},
			{
				"[w",
				function()
					vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
				end,
				desc = "Previous warning",
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
}
