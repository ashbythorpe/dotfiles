return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "n",
				desc = "Format buffer",
			},
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "v",
				desc = "Format selection",
			},
		},
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				if vim.g.autoformat or vim.b[bufnr].autoformat then
					return { timeout_ms = 500, lsp_format = "fallback" }
				end
				return nil
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				r = { "air" },

				-- JavaScript / TypeScript
				-- https://biomejs.dev/internals/language-support/
				javascript = { "biome" },
				javascriptreact = { "biome" }, -- jsx
				typescript = { "biome" },
				typescriptreact = { "biome" }, -- tsx
				astro = { "biome" },
				css = { "biome" },
				graphql = { "biome" },
				json = { "biome" },
				jsonc = { "biome" },
				-- https://prettier.io/docs/
				handlebars = { "prettier" },
				html = { "prettier" },
				less = { "prettier" },
				scss = { "prettier" },
				markdown = { "prettier" },
				vue = { "prettier" },
				yaml = { "prettier" },
				svelte = { "prettier" },
				json5 = { "prettier" },

				htmldjango = { "djlint" },

				go = { "goimports", "gofumpt" },

				sql = { "sqlfluff" },

				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
}
