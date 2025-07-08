return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({})
    end,
    opts = {},
    init = function()
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      local regex_highlighting = { "ruby" }

      -- Enable treesitter highlighting and indent by default
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Enable treesitter highlighting",
        callback = function(ctx)
          local hasStarted = pcall(vim.treesitter.start)

          if not hasStarted then
            return
          end

          if vim.list_contains(regex_highlighting, ctx.match) then
            vim.bo.syntax = "on"
            return
          end

          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    opts = {
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    },
    keys = {
      {
        "af",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
        end,
        mode = { "x", "o" },
        desc = "function",
      },
      {
        "if",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
        end,
        mode = { "x", "o" },
        desc = "function",
      },
      {
        "ac",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
        end,
        mode = { "x", "o" },
        desc = "class",
      },
      {
        "ic",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
        end,
        mode = { "x", "o" },
        desc = "class",
      },
      {
        "]f",
        function()
          require("nvim-treesitter-textobjects.move").goto_next("@function.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Next function",
      },
      {
        "[f",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous("@function.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Next function",
      },
      {
        "]c",
        function()
          require("nvim-treesitter-textobjects.move").goto_next("@class.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Next class",
      },
      {
        "[c",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous("@class.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Next class",
      },
    },
  },
}
