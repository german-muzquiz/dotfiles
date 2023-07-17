return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local icons = require("lazyvim.config").icons
    local Util = require("lazyvim.util")

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
            -- stylua: ignore
            {
              function() return vim.fn.getcwd() end,
              color = Util.fg("Directory"),
            },
          { "filename", path = 1, symbols = { modified = "+", readonly = "", unnamed = "" } },
            -- stylua: ignore
            -- {
            --   function() return require("nvim-navic").get_location() end,
            --   cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            -- },
        },
        lualine_x = {
            -- stylua: ignore
            {
              function()
                local schema = require("config.yaml_schemas").current_schema(0)
                if schema.uri == "none" then
                    return ""
                end
                if schema.name then
                  return schema.name
                else
                  return ".." .. schema.uri:sub(-50)
                end
              end,
              color = Util.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return 'codeium:' .. vim.fn['codeium#GetStatusString']() end,
              color = Util.fg("Statement"),
            },
            -- stylua: ignore
          { "filetype" },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Util.fg("Debug"),
            },
          { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Util.fg("Special") },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 1 } },
        },
        lualine_z = {
          { "location" },
        },
      },
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
