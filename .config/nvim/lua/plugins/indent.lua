
return {
  'lukas-reineke/indent-blankline.nvim',
  config = function ()
    -- Using protected call
    local status_ok, indent_blankline = pcall(require, 'indent-blankline')
    if not status_ok then
      return
    end

    indent_blankline.setup {
        show_end_of_line = true
    }
  end
}

