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

-- Create an event handler for the FileType autocommand
vim.api.nvim_create_autocmd("FileType", {
  pattern = "r",
  callback = function(_)
    vim.lsp.start({
      name = "r-analyzer",
      cmd = { "/home/ashbythorpe/parser/target/debug/parser" },
    })
  end,
})
