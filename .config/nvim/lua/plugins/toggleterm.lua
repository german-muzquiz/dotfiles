return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local status_ok, toggleterm = pcall(require, "toggleterm")
      if not status_ok then
        return
      end

      toggleterm.setup({
        size = 20,
        open_mapping = [[<c-\\>]],
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 0,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "tab",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
        },
      })
    end,
  },
}
