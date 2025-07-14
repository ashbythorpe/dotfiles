return {
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
        end,
        desc = "Search and replace",
      },
      {
        "<leader>sr",
        mode = "v",
        function()
          require("grug-far").with_visual_selection()
        end,
        desc = "Search and replace",
      },
    },
  },
}
