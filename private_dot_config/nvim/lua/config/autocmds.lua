-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "markdown", "rmd", "mdx" },
--   callback = function()
--     require("cmp").setup.buffer({
--       sources = {
--         {
--           name = "dictionary",
--           keyword_length = 2,
--         },
--       },
--     })
--
--     require("cmp_dictionary").setup({
--       paths = { "/usr/share/dict/words" },
--       exact_length = 2,
--       first_case_insensitive = true,
--       document = {
--         enable = true,
--         command = { "wn", "${label}", "-over" },
--       },
--     })
--   end,
-- })

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "r", "javascript", "typescript", "jsx", "tsx", "c", "c++" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})
