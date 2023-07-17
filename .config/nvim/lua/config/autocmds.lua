-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("myaugroup" .. name, { clear = true })
end

-- set custom help code per json/yaml schema loaded
-- vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "SessionLoadPost", "FileChangedShellPost", "Filetype" }, {
--   group = augroup("set_keywordprg"),
--   callback = function()
--     print('something changed')
--     return
--   end,
-- })
