
return {
  'nvim-lualine/lualine.nvim',
  --dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    -- Using protected call
    local status_ok, lualine = pcall(require, 'lualine')
    if not status_ok then
      return
    end
    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      symbols = { error = 'E ', warn = 'W ' },
      colored = true,
      always_visible = false,
    }

    local diff = {
      'diff',
      colored = true,
      symbols = { added = '+', modified = '~', removed = '-' }, -- changes diff symbols
      cond = hide_in_width,
    }

    local filetype = {
      'filetype',
      icons_enabled = false,
    }

    local location = {
      'location',
      padding = 0,
    }

    local function yaml_schema()
        local schema = require("yaml-companion").get_buf_schema(0)
        if schema.result[1].name == "none" then
            return ""
        end
        return schema.result[1].name
    end

    lualine.setup {
      options = {
        globalstatus = true,
        icons_enabled = false,
        theme = 'auto',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'dashboard' },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', diff, diagnostics },
        lualine_c = { 'filename' },
        lualine_x = { yaml_schema, 'encoding', 'fileformat', filetype },
        lualine_y = { 'progress' },
        lualine_z = { location },
      },
    }
  end
}

