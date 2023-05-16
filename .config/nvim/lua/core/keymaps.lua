
-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
--local opts = { silent = true }

-- Map leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

------------------- Normal mode ------------------
-- Cycle through tabs
keymap('n', '<TAB>', '<C-w>w')
-- Hide highlight search
keymap('n', '<leader>,', ':noh<CR>')
-- Go back to previous buffer
keymap('n', '<leader>6', ':b#<CR>')

