vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.number = true
vim.o.relativenumber = true

vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
end)

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.inccommand = "split"

vim.o.scrolloff = 4

vim.o.confirm = true

vim.o.mouse = "a"

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.list = true

vim.o.expandtab = true

vim.o.foldlevel = 99

vim.o.laststatus = 3

vim.o.linebreak = true

vim.o.ruler = false

vim.o.sidescrolloff = 8
vim.o.smartindent = true

vim.opt.spelllang = { "en_gb", "en_us" }

vim.o.virtualedit = "block"

vim.o.winminwidth = 5

vim.o.wrap = false

vim.o.smoothscroll = true

vim.g.markdown_recommended_style = 0
