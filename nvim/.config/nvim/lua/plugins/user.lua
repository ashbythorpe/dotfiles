return {
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
  -- {
  --   "hrsh7th/nvim-cmp",
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  --     end
  --
  --     local cmp = require("cmp")
  --
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.confirm({ select = true })
  --         elseif vim.snippet.active({ direction = 1 }) then
  --           vim.schedule(function()
  --             vim.snippet.jump(1)
  --           end)
  --         elseif has_words_before() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --     })
  --     opts.mapping["<CR>"] = nil
  --   end,
  -- },
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      win_options = {
        signcolumn = "number",
      },
      keymaps = {
        ["q"] = "actions.close",
      },
    },
    keys = {
      {
        "<leader>fo",
        "<CMD>Oil<CR>",
        desc = "Oil",
      },
      {
        "-",
        "<CMD>Oil<CR>",
        desc = "Open oil in parent directory",
      },
    },
  },
  {
    "mikavilpas/yazi.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },

    keys = {
      {
        "<leader>fy",
        function()
          require("yazi").yazi()
        end,
        { desc = "Open Yazi" },
      },
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    keys = { { "za" } },
    dependencies = {
      "kevinhwang91/promise-async",
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
    cmd = "DiffviewOpen",
    opts = function(_, opts)
      local actions = require("diffview.actions")

      opts = vim.tbl_deep_extend("force", opts, {
        view = {
          merge_tool = {
            layout = "diff4_mixed",
          },
        },
        keymaps = {
          view = {
            {
              "n",
              "<leader>gCo",
              actions.conflict_choose("ours"),
              { desc = "Choose the OURS version of a conflict" },
            },
            {
              "n",
              "<leader>gCt",
              actions.conflict_choose("theirs"),
              { desc = "Choose the THEIRS version of a conflict" },
            },
            {
              "n",
              "<leader>gCb",
              actions.conflict_choose("base"),
              { desc = "Choose the BASE version of a conflict" },
            },
            {
              "n",
              "<leader>gCa",
              actions.conflict_choose("all"),
              { desc = "Choose all the versions of a conflict" },
            },
            { "n", "dx", actions.conflict_choose("none"), { desc = "Delete the conflict region" } },
            {
              "n",
              "<leader>gCO",
              actions.conflict_choose_all("ours"),
              { desc = "Choose the OURS version of a conflict for the whole file" },
            },
            {
              "n",
              "<leader>gCT",
              actions.conflict_choose_all("theirs"),
              { desc = "Choose the THEIRS version of a conflict for the whole file" },
            },
            {
              "n",
              "<leader>gCB",
              actions.conflict_choose_all("base"),
              { desc = "Choose the BASE version of a conflict for the whole file" },
            },
            {
              "n",
              "<leader>gCA",
              actions.conflict_choose_all("all"),
              { desc = "Choose all the versions of a conflict for the whole file" },
            },
            {
              "n",
              "dX",
              actions.conflict_choose_all("none"),
              { desc = "Delete the conflict region for the whole file" },
            },
          },
        },
      })

      return opts
    end,
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
  "folke/twilight.nvim",
  {
    "rgroli/other.nvim",
    keys = {
      {
        "<leader>fO",
        "<cmd>Other<cr>",
        desc = "Other file",
      },
    },
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
  {
    "mbbill/undotree",
    keys = {
      {
        "<leader>uu",
        "<cmd>UndotreeToggle<cr>",
        desc = "Toggle Undotree",
      },
    },
  },
  {
    "Wansmer/treesj",
    keys = {
      {
        "<leader>cj",
        function()
          require("treesj").toggle()
        end,
        desc = "Split/join code",
      },
    },
    opts = {
      max_join_length = 1000000,
      use_default_keymaps = false,
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "Bekaboo/dropbar.nvim",
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    config = true,
  },
  {
    "tamton-aquib/duck.nvim",
    keys = {
      {
        "<leader>zdd",
        function()
          require("duck").hatch()
        end,
        desc = "Hatch duck",
      },
      {
        "<leader>zdk",
        function()
          require("duck").cook()
        end,
        desc = "Cook duck",
      },
    },
  },
  {
    "https://github.com/SirZenith/oil-vcs-status",
    config = function(_, opts)
      local StatusType = require("oil-vcs-status.constant.status").StatusType
      require("oil-vcs-status").setup({
        status_symbol = {
          [StatusType.Added] = "",
          [StatusType.Copied] = "󰆏",
          [StatusType.Deleted] = "",
          [StatusType.Ignored] = "",
          [StatusType.Modified] = "",
          [StatusType.Renamed] = "",
          [StatusType.TypeChanged] = "󰉺",
          [StatusType.Unmodified] = " ",
          [StatusType.Unmerged] = "",
          [StatusType.Untracked] = "",
          [StatusType.External] = "",

          [StatusType.UpstreamAdded] = "󰈞",
          [StatusType.UpstreamCopied] = "󰈢",
          [StatusType.UpstreamDeleted] = "",
          [StatusType.UpstreamIgnored] = " ",
          [StatusType.UpstreamModified] = "󰏫",
          [StatusType.UpstreamRenamed] = "",
          [StatusType.UpstreamTypeChanged] = "󱧶",
          [StatusType.UpstreamUnmodified] = " ",
          [StatusType.UpstreamUnmerged] = "",
          [StatusType.UpstreamUntracked] = " ",
          [StatusType.UpstreamExternal] = "",
        },
      })
    end,
  },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^4.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require("kitty-scrollback").setup()
    end,
  },
  {
    "giusgad/pets.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
    opts = {
      row = 6,
    },
    keys = {
      {
        "<leader>zpn",
        function()
          local name = math.random(10000)

          vim.cmd("PetsNew " .. name)
        end,
        desc = "New pet",
      },
      {
        "<leader>zpk",
        "<cmd>PetsKillAll<cr>",
        desc = "Kill all pets",
      },
    },
  },
  {
    "davidmh/mdx.nvim",
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "otavioschwanck/arrow.nvim",
    opts = {
      show_icons = true,
      leader_key = ";",
      buffer_leader_key = "m",
    },
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "3rd/image.nvim",
    dependencies = {
      "kiyoon/magick.nvim",
    },
    opts = {
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge, -- this is necessary for a good experience
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
    end,
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  "tpope/vim-sleuth",
  {
    "ronisbr/nano-theme.nvim",
  },
  {
    "kwakzalver/duckytype.nvim",
    config = true,
    cmd = "DuckyType",
  },
}
