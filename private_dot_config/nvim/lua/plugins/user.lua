return {
  -- { "nvim-neotest/neotest-plenary" },
  "rcasia/neotest-java",
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "shunsambongi/neotest-testthat",
    },
    opts = {
      adapters = {
        ["neotest-testthat"] = {},
        ["neotest-java"] = {
          ignore_wrapper = false, -- whether to ignore maven/gradle wrapper
        },
      },
    },
  },
  {
    "github/copilot.vim",
    event = "BufEnter",
    keys = {
      {
        "<C-g>",
        "copilot#Accept('')",
        mode = "i",
        expr = true,
        replace_keycodes = false,
        silent = true,
        desc = "Accept",
      },
    },
  },
  -- {
  --   "Exafunction/codeium.vim",
  --   event = "BufEnter",
  --   config = function()
  --     vim.keymap.set("i", "<C-g>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true, silent = true })
  --     vim.keymap.set("i", "<c-;>", function()
  --       return vim.fn["codeium#CycleCompletions"](1)
  --     end, { expr = true, silent = true })
  --     vim.keymap.set("i", "<c-,>", function()
  --       return vim.fn["codeium#CycleCompletions"](-1)
  --     end, { expr = true, silent = true })
  --   end,
  -- },
  {
    "nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect,preview",
      }

      local cmp = require("cmp")
      local SelectBehavior = require("cmp.types.cmp").SelectBehavior

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = SelectBehavior.Select }),
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = SelectBehavior.Select }),
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
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
    opts = {
      win_options = {
        signcolumn = "number",
      },
    },
    keys = {
      {
        "<leader>fo",
        "<CMD>Oil<CR>",
        desc = "Oil",
      },
    },
  },
  {
    "DreamMaoMao/yazi.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },

    keys = {
      { "<leader>fy", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
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
    opts = {
      view = {
        merge_tool = {
          layout = "diff4_mixed",
        },
      },
    },
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
  { "echasnovski/mini.pairs", enabled = false },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
    },
  },
  {
    "willothy/flatten.nvim",
    opts = function()
      ---@type Terminal?
      local saved_terminal

      return {
        window = {
          open = "alternate",
        },
        callbacks = {
          should_block = function(argv)
            -- Note that argv contains all the parts of the CLI command, including
            -- Neovim's path, commands, options and files.
            -- See: :help v:argv

            -- In this case, we would block if we find the `-b` flag
            -- This allows you to use `nvim -b file1` instead of
            -- `nvim --cmd 'let g:flatten_wait=1' file1`
            return vim.tbl_contains(argv, "-b")

            -- Alternatively, we can block if we find the diff-mode option
            -- return vim.tbl_contains(argv, "-d")
          end,
          pre_open = function()
            local term = require("toggleterm.terminal")
            local termid = term.get_focused_id()
            saved_terminal = term.get(termid)
          end,
          post_open = function(bufnr, winnr, ft, is_blocking)
            if is_blocking and saved_terminal then
              -- Hide the terminal while it's blocking
              saved_terminal:close()
            else
              -- If it's a normal file, just switch to its window
              vim.api.nvim_set_current_win(winnr)
            end

            -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
            -- If you just want the toggleable terminal integration, ignore this bit
            if ft == "gitcommit" or ft == "gitrebase" then
              vim.api.nvim_create_autocmd("BufWritePost", {
                buffer = bufnr,
                once = true,
                callback = vim.schedule_wrap(function()
                  vim.api.nvim_buf_delete(bufnr, {})
                end),
              })
            end
          end,
          block_end = function()
            -- After blocking ends (for a git commit, etc), reopen the terminal
            vim.schedule(function()
              if saved_terminal then
                saved_terminal:open()
                saved_terminal = nil
              end
            end)
          end,
        },
      }
    end,
    lazy = false,
    priority = 1001,
  },
  -- {
  --   "David-Kunz/gen.nvim",
  -- },
  {
    "iamcco/markdown-preview.nvim",
    ft = {
      "markdown",
    },
    build = ":call mkdp#util#install()",

    keys = {
      {
        "<leader>zm",
        "<cmd>MarkdownPreviewToggle<cr>",
        mode = "n",
        desc = "Markdown Preview",
      },
    },

    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
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
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
  {
    "michaelb/sniprun",
    run = "bash install.sh 1",
    keys = {
      {
        "<leader>cR",
        "<Cmd> SnipRun<cr>",
        desc = "Run Snippet",
        mode = { "n", "v" },
      },
    },
  },
  {
    "stevearc/overseer.nvim",
    dependencies = { "akinsho/toggleterm.nvim" },
    keys = {
      {
        "<leader>cor",
        "<cmd>OverseerRun<cr>",
        desc = "Run tasks",
      },
      {
        "<leader>cot",
        "<cmd>OverseerToggle<cr>",
        desc = "Toggle task list",
      },
      {
        "<leader>coR",
        function()
          local overseer = require("overseer")
          local tasks = overseer.list_tasks({ recent_first = true })
          if vim.tbl_isempty(tasks) then
            vim.notify("No tasks found", vim.log.levels.WARN)
          else
            overseer.run_action(tasks[1], "restart")
          end
        end,
        desc = "Restart last task",
      },
    },
    config = function()
      local overseer = require("overseer")
      overseer.register_template({
        name = "R CMD CHECK",
        builder = function(_)
          return {
            cmd = "Rscript",
            args = { "-e", "'devtools::check()'" },
          }
        end,
        condition = {
          filetype = { "r", "rmd" },
        },
      })

      overseer.register_template({
        name = "devtools::document()",
        builder = function(_)
          return {
            cmd = "Rscript",
            args = { "-e", "'devtools::document()'" },
          }
        end,
        condition = {
          filetype = { "r", "rmd" },
        },
      })

      overseer.register_template({
        name = "Build Rmd file",
        builder = function(_)
          local file = vim.fn.expand("%:p")
          local name = file:match("^.+/([^/]+)$")

          if name == "README.Rmd" then
            return {
              cmd = "Rscript",
              args = { "-e", "'devtools::build_readme()'" },
            }
          else
            return {
              cmd = "Rscript",
              args = { "-e", "'rmarkdown::render('" .. file .. "')" },
            }
          end
        end,
        condition = {
          filetype = { "rmd" },
        },
      })
    end,
  },
  {
    "folke/persistence.nvim",
    pre_save = function()
      local function get_cwd_as_name()
        local dir = vim.fn.getcwd(0)
        if dir == nil then
          return nil
        end
        return dir:gsub("[^A-Za-z0-9]", "_")
      end

      local overseer = require("overseer")

      overseer.save_task_bundle(
        get_cwd_as_name(),
        -- Passing nil will use config.opts.save_task_opts. You can call list_tasks() explicitly and
        -- pass in the results if you want to save specific tasks.
        nil,
        { on_conflict = "overwrite" } -- Overwrite existing bundle, if any
      )
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      local button = {
        action = function()
          local function get_cwd_as_name()
            local dir = vim.fn.getcwd(0)
            if dir == nil then
              return nil
            end
            return dir:gsub("[^A-Za-z0-9]", "_")
          end
          local overseer = require("overseer")
          overseer.load_task_bundle(get_cwd_as_name(), { ignore_missing = true })
          require("persistence").load()
        end,
        desc = " Restore Session",
        icon = " ",
        key = "s",
        key_format = "  %s",
      }

      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)

      opts["config"]["center"][7] = button

      return opts
    end,
  },
  {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim" },
    opts = {},
    keys = {
      {
        "<leader>cco",
        "<cmd>CompilerOpen<cr>",
        desc = "Open compiler",
      },
      {
        "<leader>cct",
        "<cmd>CompilerToggleResults<cr>",
        desc = "Toggle compiler results",
      },
      {
        "<leader>ccr",
        "<cmd>CompilerRedo<cr>",
        desc = "Redo compiler job",
      },
      {
        "<leader>ccs",
        "<cmd>CompilerStop<cr>",
        desc = "Stop compiler",
      },
    },
  },
  {
    "pappasam/nvim-repl",
    init = function()
      vim.g["repl_filetype_commands"] = {
        javascript = "node",
        python = "ipython --no-autoindent",
        r = "R",
      }
    end,
    keys = {
      { "<leader>crt", "<cmd>ReplToggle<cr>", desc = "Toggle nvim-repl" },
      { "<leader>crc", "<cmd>ReplRunCell<cr>", desc = "nvim-repl run cell" },
      { "<leader>crl", "<Plug>ReplSendLine", desc = "nvim-repl run line" },
      { "<leader>cr", "<Plug>ReplSendVisual", desc = "nvim-repl run selection", mode = "v" },
    },
  },
  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup()
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
      opts = {
        max_join_length = 1000000,
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
  },
  {
    "tomiis4/Hypersonic.nvim",
    keys = {
      {
        "<leader>zr",
        "<cmd>Hypersonic<cr>",
        desc = "Preview regex",
        mode = { "n", "v" },
      },
    },
  },
  "monaqa/dial.nvim",
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
  },
  "ronisbr/nano-theme.nvim",
  {
    "L3MON4D3/LuaSnip",
    opts = {
      region_check_events = "CursorHold,InsertLeave",
      delete_check_events = "TextChanged,InsertEnter,InsertLeave",
      jump_to_prev_snippet = "<S-Tab>",
      jump_to_next_snippet = "<Nop>",
    },
    keys = {
      { "<tab>", mode = "i", false },
      {
        "<s-tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = { "i", "s" },
      },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    opts = {
      default = {
        replace = {
          cmd = "oxi",
        },
      },
    },
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
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {},
    keys = {
      {
        "gw",
        mode = { "n", "x" },
        function()
          require("wtf").ai()
        end,
        desc = "Debug diagnostic with AI",
      },
      {
        mode = { "n" },
        "gW",
        function()
          require("wtf").search()
        end,
        desc = "Search diagnostic with Google",
      },
    },
  },
  "nvim-focus/focus.nvim",
  "dmmulroy/tsc.nvim",
  "metakirby5/codi.vim",
  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("import")
    end,
    keys = {
      {
        "<leader>ci",
        "<Cmd>Telescope import<CR>",
        desc = "Import",
      },
    },
  },
  "HakonHarnes/img-clip.nvim",
  {
    "jpalardy/vim-slime",
    config = function()
      vim.g.slime_target = "neovim"
    end,
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
  "wakatime/vim-wakatime",
  "nyoom-engineering/oxocarbon.nvim",
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
}
