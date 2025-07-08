return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },
  {
    "nvim-lspconfig",
    init = function()
      vim.lsp.enable("jsonls")
      vim.lsp.config("jsonls", {
        settings = {
          json = {
            validate = { enable = true },
          },
        },
        before_init = function(params, config)
          config.settings.json.schemas = require("schemastore").json.schemas()
        end,
      })

      vim.lsp.enable("yamlls")
      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
          },
        },
        before_init = function (params, config)
          config.settings.yaml.schemas = require("schemastore").yaml.schemas()
        end
      })
    end,
  },
}
