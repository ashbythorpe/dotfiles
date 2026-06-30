return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  init = function()
    require("lint").linters_by_ft = {
      dockerfile = { "hadolint" },
      cmake = { "cmakelint" },
      sql = { "sqlfluff" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      desc = "Lint file",
      group = vim.api.nvim_create_augroup("lint", { clear = true }),
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
