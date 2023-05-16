
return {
  'someone-stole-my-name/yaml-companion.nvim',
  dependencies = {
	"neovim/nvim-lspconfig",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
  },
  config = function ()
    -- Using protected call
    local status_ok, companion = pcall(require, 'yaml-companion')
    if not status_ok then
      return
    end

    require("telescope").load_extension("yaml_schema")

    companion.setup {
        -- Built in file matchers
        builtin_matchers = {
            -- Detects Kubernetes files based on content
            kubernetes = { enabled = true },
            cloud_init = { enabled = true }
        },
        -- Additional schemas available in Telescope picker
        schemas = {
            {
                name = "Kubernetes 1.22.4",
                uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
            },
            {
                name = "GitHub workflow",
                uri = "http://json.schemastore.org/github-workflow",
            },
            {
                name = "Kustomize files",
                uri = "http://json.schemastore.org/kustomization",
            },
            {
                name = "Helm charts",
                uri = "http://json.schemastore.org/chart",
            },
            {
                name = "Docker Compose",
                uri = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
            },
            {
                name = "AWS CloudFormation",
                uri = "https://s3.amazonaws.com/cfn-resource-specifications-us-east-1-prod/schemas/2.15.0/all-spec.json",
            },
        },
        -- Pass any additional options that will be merged in the final LSP config
        lspconfig = {
            flags = {
                debounce_text_changes = 150,
            },
            settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
                validate = true,
                format = { enable = true },
                hover = true,
                schemaStore = {
                    enable = true,
                    url = "https://www.schemastore.org/api/json/catalog.json",
                },
                schemaDownload = { enable = true },
                schemas = {},
                trace = { server = "debug" },
            },
            },
        },
    }
    end
}

