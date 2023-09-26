-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require("which-key").register({
  ["<leader>h"] = { name = "+Grapple" },
})

local function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

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
