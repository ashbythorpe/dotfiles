-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

require("config/private/private")

vim.opt.tabstop = nil

vim.cmd([[ let R_assign = 0 ]])
vim.g.codeium_no_map_tab = 1
vim.opt.completeopt = "menu,menuone,noinsert,noselect,preview"
vim.g.copilot_no_tab_map = true

vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
