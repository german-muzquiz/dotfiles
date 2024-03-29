
return{
  'hrsh7th/nvim-cmp',
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    {
      "L3MON4D3/LuaSnip",
      event = "InsertCharPre",
      dependencies = "rafamadriz/friendly-snippets"
    },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
  },
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
  config = function()
    -- Using protected call
    local cmp_ok, cmp = pcall(require, "cmp")
    if not cmp_ok then
      return
    end
    local luasnip_ok, luasnip = pcall(require, "luasnip")
    if not luasnip_ok then
      return
    end
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },
      formatting = {
        fields = { "abbr", "menu", "kind" },
        format = function(entry, item)
          local menu_icon = {
            nvim_lsp = "LSP",
            luasnip = "⋗",
            buffer = "BUF",
            path = "PATH",
            nvim_lua = "LUA",
          }
          item.menu = menu_icon[entry.source.name]
          return item
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<TAB>'] = cmp.mapping.select_next_item(),
        ['<S-TAB>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "luasnip" },
        { name = "path" },
        { name = "nvim_lua" },
      })
    })
  end
}

