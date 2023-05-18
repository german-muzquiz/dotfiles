
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.1',
  dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep', 'sharkdp/fd' },
  config = function ()
    -- Using protected call
    local status_ok, telescope = pcall(require, "telescope")
    if not status_ok then
      return
    end

    -- Configuration
    telescope.setup {
      defaults = {
        prompt_prefix = "> ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules", ".idea" },
      },
      pickers = {
          buffers = {
              ignore_current_buffer = true,
              sort_mru = true,
          },
      },
    }

    -- Setting Telescope Keymaps
    local keymap = vim.keymap.set
    keymap("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true, desc = "Telescope - Find files" })
    keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true, desc = "Telescope - Grep" })
    keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", { silent = true, desc = "Telescope - Diagnostics" })
    keymap("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true, desc = "Telescope - Find buffers" })
    keymap("n", "<leader>fh", ":Telescope help_tags<CR>", { silent = true, desc = "Telescope - Find help" })
    keymap("n", "<leader>fk", ":Telescope keymaps<CR>", { silent = true, desc = "Telescope - Keymaps" })
  end
}

