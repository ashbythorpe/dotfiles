-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require("which-key").register({
  ["<leader>h"] = { name = "+Grapple" },
  ["<leader>z"] = { name = "+Other" },
  ["<leader>zd"] = { name = "+Duck" },
  ["<leader>cc"] = { name = "+Compiler" },
  ["<leader>co"] = { name = "+Overseer" },
  ["<leader>cr"] = { name = "+REPL" },
  ["<leader>gC"] = { name = "+Conflict" },
  ["<leader>gh"] = { name = "+Hunk" },
})

vim.keymap.set("n", ";", function()
  local id = 0
  local found = false
  local switched = false
  local first = true
  local current_buf = vim.api.nvim_get_current_buf()
  require("bufferline.groups").action("pinned", function(buf)
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

  if not switched then
    vim.cmd("buffer " .. id)
  end
end, { desc = "Next pinned buffer" })

vim.keymap.set("n", ",", function()
  local id = 0
  local switched = false
  local first = true
  local last = false
  local current_buf = vim.api.nvim_get_current_buf()
  require("bufferline.groups").action("pinned", function(buf)
    if switched then
      id = buf.id
      return
    end

    if first then
      first = false
      id = buf.id
      if buf.id == current_buf then
        last = true
        switched = true
      end
      return
    end

    if buf.id == current_buf then
      vim.cmd("buffer " .. id)
      switched = true
    else
      id = buf.id
    end
  end)

  if last or not switched then
    vim.cmd("buffer " .. id)
  end
end, { desc = "Previous pinned buffer" })

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

vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, { desc = "Rename" })

vim.keymap.set("n", "<leader>u1", function()
  if vim.opt.colorcolumn:get()[1] == nil then
    vim.opt.colorcolumn = { 80 }
  else
    vim.opt.colorcolumn = { nil }
  end
end, { desc = "Toggle colorcolumn" })

vim.keymap.set("n", "<leader>u2", function()
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

vim.keymap.set("n", "<leader>u3", function()
  if vim.g.colors_name == "tokyonight" then
    vim.cmd.colorscheme("oxocarbon")
  else
    vim.cmd.colorscheme("tokyonight")
  end
end, { desc = "Toggle colorscheme" })
