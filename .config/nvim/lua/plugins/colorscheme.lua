
-- return {
--   'sainnhe/sonokai',
--   priority = 1000,
--   config = function()
--     vim.g.sonokai_style = "atlantis"
--     --vim.g.sonokai_current_word = "underline"
--     vim.cmd.colorscheme 'sonokai'
--   end,
-- }

return {
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'tokyonight-storm'
  end,
}
