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
  },
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
  -- "Bekaboo/dropbar.nvim",
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    config = true,
  },
  {
    "tamton-aquib/duck.nvim",
    keys = {
      {
        "<leader>odd",
        function()
          require("duck").hatch()
        end,
        desc = "Hatch duck",
      },
      {
        "<leader>odk",
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
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    config = true,
  },
  {
    "giusgad/pets.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
    opts = {
      row = 6,
    },
    keys = {
      {
        "<leader>opn",
        function()
          local name = math.random(10000)

          vim.cmd("PetsNew " .. name)
        end,
        desc = "New pet",
      },
      {
        "<leader>opk",
        "<cmd>PetsKillAll<cr>",
        desc = "Kill all pets",
      },
    },
  },
  {
    "davidmh/mdx.nvim",
    config = true,
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    config = true,
  },
  -- {
  --   "3rd/image.nvim",
  --   dependencies = {
  --     "kiyoon/magick.nvim",
  --   },
  --   opts = {
  --     max_width = 100,
  --     max_height = 12,
  --     max_height_window_percentage = math.huge, -- this is necessary for a good experience
  --     max_width_window_percentage = math.huge,
  --     window_overlap_clear_enabled = true,
  --     window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  --   },
  --   integrations = {
  --     markdown = {
  --       enabled = false,
  --     },
  --   },
  -- },
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
    },
  },
  "tpope/vim-sleuth",
  "ronisbr/nano-theme.nvim",
  {
    "Saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
      },
    },
  },
  {
    "kwakzalver/duckytype.nvim",
    config = true,
    cmd = "DuckyType",
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kulala_ls = {},
      },
    },
  },
  {
    "hedyhli/markdown-toc.nvim",
    cmd = { "Mtoc" },
    config = true,
  },
  {
    "folke/snacks.nvim",
    opts = {
      styles = {
        zen = {
          backdrop = {
            transparent = false,
          },
        },
      },
      image = {
        enabled = true,
        doc = {
          inline = false,
        },
      },
    },
    keys = {
      {
        "<leader>su",
        function()
          Snacks.picker.undo()
        end,
        desc = "Undo history",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "classic",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kulala_ls = { mason = false },
        air = { mason = false },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          highlight = {
            backdrop = false,
          },
        },
      },
    },
  },
}
