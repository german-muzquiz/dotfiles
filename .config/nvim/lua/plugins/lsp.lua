return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        -- Using protected call
        local lsp_ok, lspconfig = pcall(require, "lspconfig")
        if not lsp_ok then
            return
        end
        local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if not cmp_nvim_lsp_ok then
            return
        end

        -- Setting up icons for diagnostics
        local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- Setting up capabilities
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Setting up servers
        require("core.ls_config")
        for server, config in pairs(Language_server_config) do
            if lspconfig[server] then
                local setup = { capabilities = capabilities }
                if config.cmd then
                    setup.cmd = config.cmd
                end
                if config.workspace_folders then
                    setup.workspace_folders = config.workspace_folders
                end
                if config.settings then
                    setup.settings = config.settings
                end
                if config.filetypes then
                    setup.filetypes = config.filetypes
                end
                if config.flags then
                    setup.flags = config.flags
                end
                lspconfig[server].setup(setup)
            end
        end

        vim.lsp.set_log_level("INFO")
    end,
}
