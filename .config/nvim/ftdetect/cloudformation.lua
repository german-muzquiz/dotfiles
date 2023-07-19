vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*/cloudformation/*.yaml",
    "*/cloudformation/*.yml",
    "*cf.yaml",
    "*cf.yml",
    "*cft.yaml",
    "*cft.yml",
  },
  group = vim.api.nvim_create_augroup('myaugroup_ft', { clear = true }),
  callback = function()
    vim.opt.filetype = "yaml.cloudformation"
  end,
})

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group = vim.api.nvim_create_augroup('myaugroup_ft', { clear = false }),
  callback = function(args)
    if vim.bo.filetype ~= "yaml.cloudformation" then
      return
    end
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    local bufuri = vim.uri_from_bufnr(bufnr)
    client.config.settings =
        vim.tbl_deep_extend("force", client.config.settings, {
          yaml = {
            schemas = {
              ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json"] = bufuri,
            },
            customTags = {
              "!And scalar",
              "!And mapping",
              "!And sequence",
              "!If scalar",
              "!If mapping",
              "!If sequence",
              "!Not scalar",
              "!Not mapping",
              "!Not sequence",
              "!Equals scalar",
              "!Equals mapping",
              "!Equals sequence",
              "!Or scalar",
              "!Or mapping",
              "!Or sequence",
              "!FindInMap scalar",
              "!FindInMap mappping",
              "!FindInMap sequence",
              "!Base64 scalar",
              "!Base64 mapping",
              "!Base64 sequence",
              "!Cidr scalar",
              "!Cidr mapping",
              "!Cidr sequence",
              "!Ref scalar",
              "!Ref mapping",
              "!Ref sequence",
              "!Sub scalar",
              "!Sub mapping",
              "!Sub sequence",
              "!GetAtt scalar",
              "!GetAtt mapping",
              "!GetAtt sequence",
              "!GetAZs scalar",
              "!GetAZs mapping",
              "!GetAZs sequence",
              "!ImportValue scalar",
              "!ImportValue mapping",
              "!ImportValue sequence",
              "!Select scalar",
              "!Select mapping",
              "!Select sequence",
              "!Split scalar",
              "!Split mapping",
              "!Split sequence",
              "!Join scalar",
              "!Join mapping",
              "!Join sequence"
            },
          }
        })
    client.workspace_did_change_configuration(client.config.settings)
  end,
})
