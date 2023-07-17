return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  opts = {
    autoformat = false,
    -- LSP Server Settings
    ---@type lspconfig.options
    servers = {
      terraformls = {},
      pyright = {},
      bashls = {},
      gopls = {},
      jsonls = {},
      lua_ls = {
        -- mason = false, -- set to false if you don't want this server to be installed with mason
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
      yamlls = {},
      groovyls = {
        filetypes = { "Jenkinsfile", "groovy" },
        cmd = {
          "java",
          "-jar",
          vim.fn.stdpath("data") .. "/mason/packages/groovy-language-server/build/libs/groovy-language-server-all.jar",
        },
      },
    },
    -- you can do any additional lsp server setup here
    -- return true if you don't want this server to be setup with lspconfig
    ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
    setup = {
      -- example to setup with typescript.nvim
      -- tsserver = function(_, opts)
      --   require("typescript").setup({ server = opts })
      --   return true
      -- end,
      -- Specify * to use this function as a fallback for any server
      -- ["*"] = function(server, opts) end,
    },
  },
}
