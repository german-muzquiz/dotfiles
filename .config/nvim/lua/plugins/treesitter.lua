
return {
  'nvim-treesitter/nvim-treesitter',
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  config = function ()
    -- Using protected call
    local status_ok, treesitter = pcall(require, 'nvim-treesitter')
    if not status_ok then
      return
    end

    treesitter.setup {
        highlight = {
            enable = true
        },
        ensure_installed = {
            'json',
            'lua',
            'go',
            'python',
            'hcl',
        },
    }
  end
}

