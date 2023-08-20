return {
  "nvim-telescope/telescope.nvim",
  commit = vim.fn.has("nvim-0.9.0") == 0 and "057ee0f8783" or nil,
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep", "sharkdp/fd" },
  keys = {
    { "<leader>,", false },
    { "<leader>/", false },
    { "<leader><space>", false },
    { "<leader>fb", false },
    { "<leader>ff", false },
    { "<leader>fF", false },
    { "<leader>fr", false },
    { "<leader>fR", false },
    { "<leader>sg", false },
    { "<leader>sG", false },
    { "<leader>gs", false },
  },
}
