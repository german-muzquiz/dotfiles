vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

local venv_path = require('config.project').detect_venv()
if venv_path ~= nil then
    vim.api.nvim_create_autocmd({ "LspAttach" }, {
        group = vim.api.nvim_create_augroup('myaugroup_python', { clear = true }),
        callback = function(args)
            if vim.bo.filetype ~= "python" then
                return
            end
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            client.config.settings =
                vim.tbl_deep_extend("force", client.config.settings,
                    { python = { pythonPath = venv_path } })
            client.workspace_did_change_configuration(client.config.settings)
        end,
    })
    local ok, dap = pcall(require, "dap-python")
    if ok then
        dap.resolve_python = function()
            return venv_path
        end
    end
end
