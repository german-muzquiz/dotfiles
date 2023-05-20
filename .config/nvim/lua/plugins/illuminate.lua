
return {
  "RRethy/vim-illuminate",
  config = function ()
    local status_ok, illuminate = pcall(require, "vim-illuminate")
    if not status_ok then
      return
    end
    illuminate.setup({})
  end
}

