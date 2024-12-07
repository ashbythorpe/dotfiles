-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require("which-key").add({
  { "<leader>z", group = "Other" },
  { "<leader>zd", group = "Duck" },
  { "<leader>zp", group = "Pets" },
})

vim.keymap.set("n", ",", function()
  local id = 0
  local found = false
  local switched = false
  local first = true
  local current_buf = vim.api.nvim_get_current_buf()
  local any_pinned = false
  require("bufferline.groups").action("pinned", function(buf)
    any_pinned = true
    if switched then
      return
    end

    if first then
      first = false
      id = buf.id
      if buf.id == current_buf then
        found = true
      end
      return
    end

    if found then
      vim.cmd("buffer " .. buf.id)
      switched = true
    elseif buf.id == current_buf then
      found = true
    end
  end)

  if not any_pinned then
    vim.notify("No pinned buffers", "warn")
  elseif not switched then
    vim.cmd("buffer " .. id)
  end
end, { desc = "Next pinned buffer" })

vim.keymap.set("n", "<leader>bx", function()
  local groups = require("bufferline.groups")
  groups.action("pinned", function(buf)
    groups.remove_element("pinned", buf)
  end)
  require("bufferline.ui").refresh()
end, { desc = "Reset pinned buffers" })

local function get_cwd_as_name()
  local dir = vim.fn.getcwd(0)
  return dir:gsub("[^A-Za-z0-9]", "_")
end

vim.keymap.set("n", "<leader>qs", function()
  local overseer = require("overseer")
  overseer.load_task_bundle(get_cwd_as_name(), { ignore_missing = true })
  require("persistence").load()
end, { desc = "Restore session" })

vim.keymap.set("n", "<leader>u|", function()
  if vim.opt.colorcolumn:get()[1] == nil then
    vim.opt.colorcolumn = { 80 }
  else
    vim.opt.colorcolumn = { nil }
  end
end, { desc = "Toggle colorcolumn" })

vim.keymap.set("n", "<leader>up", function()
  if vim.b.copilot_enabled == nil then
    vim.b.copilot_enabled = false
  else
    vim.b.copilot_enabled = not vim.b.copilot_enabled
  end
end, { desc = "Toggle Copilot" })

-- vim.keymap.set("n", "<leader>u2", function()
--   if vim.g.codeium_enabled == nil then
--     vim.g.codeium_enabled = false
--   else
--     vim.g.codeium_enabled = not vim.g.codeium_enabled
--   end
-- end, { desc = "Toggle Codeium" })

vim.keymap.set("n", "<leader>uN", function()
  if vim.g.colors_name == "tokyonight-moon" then
    vim.o.background = "light"
    vim.cmd.colorscheme("nano-theme")
  else
    vim.o.background = "dark"
    vim.cmd.colorscheme("tokyonight")
  end
end, { desc = "Toggle colorscheme" })

-- Switch between 2 and 4 spaces on tab
-- vim.keymap.set("n", "<leader>uI", function()
--   if vim.opt.shiftwidth:get() == 4 then
--     vim.opt.shiftwidth = 2
--     vim.opt.tabstop = 2
--     vim.opt.softtabstop = 2
--     vim.notify("Indent width set to 2", "info")
--   else
--     vim.opt.shiftwidth = 4
--     vim.opt.tabstop = 4
--     vim.opt.softtabstop = 4
--     vim.notify("Indent width set to 4", "info")
--   end
-- end, { desc = "Toggle indent width" })
