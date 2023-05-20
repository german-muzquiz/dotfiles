
return {
  'ggandor/leap.nvim',
  dependencies = {
      "tpope/vim-repeat",
  },
  config = function()
    -- Using protected call
    local status_ok, leap = pcall(require, 'leap')
    if not status_ok then
      return
    end

    leap.set_default_keymaps()
  end,
}
