-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
--local opts = { silent = true }

-- Map leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

------------------- Normal mode ------------------
-- Cycle through tabs
keymap("n", "<TAB>", "<C-w>w")
-- Hide highlight search
keymap("n", "<leader>,", ":noh<CR>")
-- Go back to previous buffer
keymap("n", "<leader>6", ":b#<CR>")
-- Setting keymaps for lsp
keymap("n", "K", vim.lsp.buf.hover,
    {
        silent = true,
        desc =
        "LSP - Displays hover information about the symbol under the cursor in a floating window. Calling the function twice will jump into the floating window."
    })
keymap("n", "gD", vim.lsp.buf.declaration,
    { silent = true, desc = "LSP - Jumps to the declaration of the symbol under the cursor." })
-- keymapset("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>",
    {
        silent = true,
        desc =
        "LSP - Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope."
    })
keymap("n", "gt", vim.lsp.buf.type_definition,
    {
        silent = true,
        desc = "LSP - Jumps to the definition of the type of the symbol under the cursor."
    })
keymap("n", "gI", vim.lsp.buf.implementation,
    {
        silent = true,
        desc = "LSP - Lists all the implementations for the symbol under the cursor in the quickfix window."
    })
keymap("n", "gr", "<cmd>Telescope lsp_references<CR>",
    {
        silent = true,
        desc = "LSP - Lists LSP references for word under the cursor, jumps to reference on <cr>"
    })
keymap("n", "dl", vim.diagnostic.open_float,
    { silent = true, desc = "LSP - Show diagnostics in a floating window." })
keymap("n", "d]", vim.diagnostic.goto_next,
    { silent = true, desc = "LSP - Move to the next diagnostic." })
keymap("n", "d[", vim.diagnostic.goto_prev,
    { silent = true, desc = "LSP - Move to the previous diagnostic in the current buffer." })
keymap("n", "<leader>la", vim.lsp.buf.code_action,
    {
        silent = true,
        desc = "LSP - Selects a code action available at the current cursor position."
    })
keymap("n", "<leader>lr", vim.lsp.buf.rename,
    { silent = true, desc = "LSP - Renames all references to the symbol under the cursor." })
keymap("n", "<leader>ls", vim.lsp.buf.signature_help,
    {
        silent = true,
        desc =
        "LSP - Displays signature information about the symbol under the cursor in a floating window. "
    })
keymap("n", "<leader>lq", vim.diagnostic.setloclist,
    { silent = true, desc = "LSP - Add buffer diagnostics to the location list." })
keymap("n", "<leader>li", vim.cmd.LspInfo,
    { silent = true, desc = "LSP - Display information about running language servers." })
keymap("n", "<leader>r", vim.lsp.buf.format,
    { silent = true, desc = "LSP - Format current buffer." })
