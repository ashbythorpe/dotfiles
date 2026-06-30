return {
	{
		"b0o/SchemaStore.nvim",
		lazy = true,
		version = false, -- last release is way too old
	},
	{
		"nvim-lspconfig",
		opts = {
			servers = {
				jsonls = {
					settings = {
						json = {
							validate = { enable = true },
						},
					},
					before_init = function(params, config)
						config.settings.json.schemas = require("schemastore").json.schemas()
					end,
				},
				yamlls = {
					settings = {
						redhat = { telemetry = { enabled = false } },
						yaml = {
							keyOrdering = false,
							format = {
								enable = true,
							},
							validate = true,
							schemaStore = {
								enable = false,
								url = "",
							},
						},
					},
					before_init = function(params, config)
						config.settings.yaml.schemas = require("schemastore").yaml.schemas()
					end,
				},
			},
		},
	},
}
