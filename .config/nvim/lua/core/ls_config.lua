-- -------------------------------------------------------------------------
-- ------------------ Language Servers Configuration -----------------------
-- -------------------------------------------------------------------------
--
-- For a list of all available language server names see: :help lspconfig-all
-- Available fields on each language server (from :help lspconfig-setup):
-- "settings": Language server specific configuration. See docs for each language server.
-- "cmd": Command that launches the language server process.
-- "workspace_folders": List of workspace folders passed to the language server.
-- "filetypes" (list[string]): Set of file types applicable to the lanuage server.
-- "flags" (table): A table with flags for the client.
--
Language_server_config = {
    terraformls = {},
    pyright = {},
    bashls = {},
    gopls = {},
    jsonls = {},
    yamlls = {
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
                completion = true,
                customTags = {
                    "!Ref",
                    "!Ref Scalar",
                    "!fn",
                    "!And",
                    "!Not",
                    "!If",
                    "!Equals",
                    "!Or",
                    "!FindInMap sequence",
                    "!Base64",
                    "!Cidr",
                    "!Sub",
                    "!GetAtt",
                    "!GetAZs",
                    "!ImportValue",
                    "!Select",
                    "!Split",
                    "!Join sequence",
                },
            },
        },
    },
    groovyls = {
        filetypes = { "Jenkinsfile", "groovy" },
        cmd = { "java", "-jar",
            vim.fn.stdpath("data") .. "/mason/packages/groovy-language-server/build/libs/groovy-language-server-all.jar" },
    },
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    },
                },
            },
        },
    },
}
