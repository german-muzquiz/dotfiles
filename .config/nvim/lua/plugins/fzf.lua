return {
  "junegunn/fzf.vim",
  dependencies = {
    "junegunn/fzf",
    "BurntSushi/ripgrep",
  },
  keys = {
    { "<leader><leader>", "<cmd>Files<CR>", desc = "find files" },
    { "<leader>ff", "<cmd>Files<CR>", desc = "find files" },
    { "<leader>fb", "<cmd>Buffers<CR>", desc = "find buffers" },
    { "<leader>/", "<cmd>Rg<CR>", desc = "grep" },
  },
}
