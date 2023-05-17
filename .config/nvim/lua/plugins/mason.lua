return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
    },
    build = function()
        pcall(vim.cmd, "MasonUpdate") -- TODO: disable lua_ls warning
    end,
    cmd = "Mason",
    event = "BufReadPre",
    config = function()
        -- Using protected call
        local mason_ok, mason = pcall(require, "mason")
        if not mason_ok then
            return
        end
        local mason_lspcfg_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
        if not mason_lspcfg_ok then
            return
        end

        -- Seeting up Mason
        mason.setup({
            ui = {
                border = "rounded",
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            },
            log_level = vim.log.levels.INFO,
            max_concurrent_installers = 4,
            PATH = "prepend",
        })
        --
        -- -- Setting up Mason LSP Bridge
        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls",
                "bashls",
                "jsonls",
                "pyright",
                "terraformls",
                "gopls",
                "yamlls",
                "groovyls",
            },
            automatic_installation = true,
        })

        mason_lspconfig.setup_handlers({
            -- YAML
            ["yamlls"] = function()
                -- TODO: Figure out how to call my lsp_attach from inside plugin on_attach
                local status_ok, lspconfig = pcall(require, "lspconfig")
                if not status_ok then
                    return
                end
                require("core.ls_config")
                local yamlconfig = require("yaml-companion").setup({
                    lspconfig = Language_server_config["yamlls"],
                })
                lspconfig["yamlls"].setup(yamlconfig)
            end
        })

        -- Setting up keymaps
        vim.keymap.set("n", "<leader>lI", vim.cmd.Mason, { silent = true })
    end,
}
