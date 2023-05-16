
return {
  'numToStr/Comment.nvim',
  config = function ()
    -- Using protected call
    local status_ok, comment = pcall(require, 'Comment')
    if not status_ok then
      return
    end

    comment.setup {
    }
  end
}

