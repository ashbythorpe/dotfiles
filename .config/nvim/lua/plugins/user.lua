return {
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "static",
    },
  },
  -- { "nvim-neotest/neotest-plenary" },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "shunsambongi/neotest-testthat",
    },
    opts = {
      adapters = {
        ["neotest-testthat"] = {},
      },
    },
  },
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
    end,
  },
  {
    "nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect,preview",
      }

      local cmp = require("cmp")
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    keys = {
      {
        "<leader>fB",
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        desc = "File browser",
      },
    },
  },
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    config = function()
      require("oil").setup()
    end,
    keys = {
      {
        "<leader>fo",
        "<CMD>Oil<CR>",
        desc = "Oil",
      },
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    keys = { { "za" } },
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<Cmd>DiffviewOpen<CR>", desc = "Status/diffs" },
      { "<leader>gf", "<Cmd>DiffviewFileHistory %<CR>", desc = "Current file history" },
      { "<leader>gF", "<Cmd>DiffviewFileHistory<CR>", desc = "All file history" },
    },
  },
  {
    "folke/zen-mode.nvim",
    keys = {
      {
        "<leader>uz",
        function()
          require("zen-mode").toggle({})
        end,
        desc = "Toggle Zen mode",
      },
    },
  },
  {
    "cbochs/grapple.nvim",
    keys = {
      {
        "<leader>ha",
        function()
          require("grapple").tag()
        end,
        desc = "Add file",
      },
      {
        "<leader>hd",
        function()
          require("grapple").untag()
        end,
        desc = "Remove file",
      },
      {
        "<leader>ht",
        function()
          require("grapple").toggle()
        end,
        desc = "Toggle file",
      },
      {
        "<leader>hx",
        function()
          require("grapple").reset()
        end,
        desc = "Reset tags",
      },
      {
        "<leader>hs",
        function()
          require("grapple").popup_tags()
        end,
        desc = "Tags menu",
      },
      {
        "<leader>hp",
        function()
          require("grapple").select({ key = "pinned" })
        end,
        desc = "Select pinned tag",
      },
      {
        "<leader>hP",
        function()
          require("grapple").toggle({ key = "pinned" })
        end,
        desc = "Pin tag",
      },
      {
        "<leader>h;",
        function()
          require("grapple").cycle_forward()
        end,
        desc = "Cycle forward through tags",
      },
      {
        "<leader>h,",
        function()
          require("grapple").cycle_backward()
        end,
        desc = "Cycle backward through tags",
      },
      {
        "<leader>hh",
        function()
          local tags = require("grapple").tags()
          local s = ""
          local current_path = vim.api.nvim_buf_get_name(0)
          for _, tag in ipairs(tags) do
            local file_path = tag.file_path
            local file_str = file_path:match("[^/]*$")
            if file_path == current_path then
              s = s .. "CURRENT: " .. file_str .. "\n"
            else
              s = s .. file_str .. "\n"
            end
          end
          vim.notify(s:sub(1, -2))
        end,
        desc = "List tags",
      },
    },
  },
  {
    "rgroli/other.nvim",
    config = function()
      require("other-nvim").setup({
        "livewire",
        "angular",
        "laravel",
        "rails",
        "golang",
        mappings = {
          {
            pattern = "R/(.*).R",
            target = "tests/testthat/test-%1.R",
          },
        },
      })
    end,
  },
  { "echasnovski/mini.pairs", enabled = false },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
    },
  },
  {
    "abecodes/tabout.nvim",
    wants = { "nvim-treesitter" },
    after = { "nvim-cmp" },
    opts = {
      tabkey = "<C-x>",
    },
  },
  {
    "willothy/flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001,
  },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = function(_, opts) require'lsp_signature'.setup(opts) end
  -- }
}
