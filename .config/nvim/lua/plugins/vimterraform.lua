
return {
  'hashivim/vim-terraform',
  config = function ()
    -- Using protected call
    local status_ok, terraform = pcall(require, 'terraform')
    if not status_ok then
      return
    end

    terraform.setup {
    }
  end
}

