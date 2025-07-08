return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      { "<leader>f", group = "file" }, -- group
      {
        "<leader>b",
        group = "buffers",
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },
      { "<leader>g", group = "git" },
      { "<leader>q", group = "session" },
      { "<leader>s", group = "search" },
      { "<leader>u", group = "toggle" },
      { "<leader>x", group = "trouble" },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
