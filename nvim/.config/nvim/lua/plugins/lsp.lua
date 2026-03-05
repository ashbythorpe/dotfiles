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
    config = function()
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

      vim.lsp.enable("lua_ls")
      vim.lsp.config("lua_ls", {
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
      })

      vim.lsp.enable("vtsls")
      vim.lsp.config("vtsls", {
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              maxInlayHintLength = 30,
              completion = {
                enableServerSideFuzzyMatch = true,
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
      })

      vim.lsp.enable("ruff")
      vim.lsp.config("ruff", {
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
      })

      vim.lsp.enable("basedpyright")
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "off",
            },
          },
        },
      })

      vim.lsp.enable({ "gopls" })
      vim.lsp.config("gopls", {
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
      })

      vim.lsp.enable({ "dockerls", "docker_compose_language_service" })

      vim.lsp.enable({ "cssls", "html" })

      vim.lsp.enable("ocamllsp")

      vim.lsp.enable({ "clangd", "neocmake" })

      vim.lsp.enable("rust_analyzer")

      vim.lsp.enable('wgsl_analyzer')
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
          vim.diagnostic.jump({ count = 1, severity = "ERROR" })
        end,
        desc = "Next error",
      },
      {
        "[e",
        function()
          vim.diagnostic.jump({ count = -1, severity = "ERROR" })
        end,
        desc = "Previous error",
      },
      {
        "]w",
        function()
          vim.diagnostic.jump({ count = 1, severity = "WARN" })
        end,
        desc = "Next warning",
      },
      {
        "[w",
        function()
          vim.diagnostic.jump({ count = -1, severity = "WARN" })
        end,
        desc = "Previous warning",
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    config = true,
  },
}
