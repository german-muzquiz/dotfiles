return {
  "tpope/vim-fugitive",
  keys = {
    { "<leader>gs", "<cmd>Git<CR>", desc = "status" },
    { "<leader>gh", "<cmd>0Gclog<CR>", desc = "history of current file" },
    { "<leader>gc", "<cmd>Git commit<CR>", desc = "commit" },
    { "<leader>gp", "<cmd>Git pull<CR>", desc = "pull" },
    { "<leader>gP", "<cmd>Git push<CR>", desc = "push" },
    { "<leader>gb", "<cmd>Git blame<CR>", desc = "blame" },
    -- { "<leader>gd", "<cmd>Gvdiffsplit!<CR>", desc = "diff" },
  },
  config = function()
    local status_ok, fugitive = pcall(require, "vim-fugitive")
    if not status_ok then
      return
    end
    fugitive.setup({})
  end,
}
