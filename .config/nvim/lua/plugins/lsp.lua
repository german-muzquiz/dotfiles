
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

		-- Setting up on_attach
		local on_attach = function(_, bufnr)
            local keymap = vim.keymap.set

			-- Setting keymaps for lsp
			keymap("n", "K", vim.lsp.buf.hover, { silent = true, buffer = bufnr, desc = "LSP - Displays hover information about the symbol under the cursor in a floating window. Calling the function twice will jump into the floating window." })
			keymap("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = bufnr, desc = "LSP - Jumps to the declaration of the symbol under the cursor." })
			-- keymapset("n", "gd", vim.lsp.buf.definition, opts)
			keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { silent = true, buffer = bufnr, desc = "LSP - Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope." })
			keymap("n", "gt", vim.lsp.buf.type_definition, { silent = true, buffer = bufnr, desc = "LSP - Jumps to the definition of the type of the symbol under the cursor." })
			keymap("n", "gI", vim.lsp.buf.implementation, { silent = true, buffer = bufnr, desc = "LSP - Lists all the implementations for the symbol under the cursor in the quickfix window." })
			keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", { silent = true, buffer = bufnr, desc = "LSP - Lists LSP references for word under the cursor, jumps to reference on <cr>" })
			keymap("n", "dl", vim.diagnostic.open_float, { silent = true, buffer = bufnr, desc = "LSP - Show diagnostics in a floating window." })
			keymap("n", "d]", vim.diagnostic.goto_next, { silent = true, buffer = bufnr, desc = "LSP - Move to the next diagnostic." })
			keymap("n", "d[", vim.diagnostic.goto_prev, { silent = true, buffer = bufnr, desc = "LSP - Move to the previous diagnostic in the current buffer." })
			keymap("n", "<leader>la", vim.lsp.buf.code_action, { silent = true, buffer = bufnr, desc = "LSP - Selects a code action available at the current cursor position." })
			keymap("n", "<leader>lr", vim.lsp.buf.rename, { silent = true, buffer = bufnr, desc = "LSP - Renames all references to the symbol under the cursor." })
			keymap("n", "<leader>ls", vim.lsp.buf.signature_help, { silent = true, buffer = bufnr, desc = "LSP - Displays signature information about the symbol under the cursor in a floating window. " })
			keymap("n", "<leader>lq", vim.diagnostic.setloclist, { silent = true, buffer = bufnr, desc = "LSP - Add buffer diagnostics to the location list." })
			keymap("n", "<leader>li", vim.cmd.LspInfo, { silent = true, buffer = bufnr, desc = "LSP - Display information about running language servers." })
			keymap("n", "<leader>r", vim.lsp.buf.format, { silent = true, buffer = bufnr, desc = "LSP - Format current buffer." })
		end

		-- Setting up servers
		local servers = { "terraformls", "pyright", "bashls", "gopls", "jsonls", "yamlls" }
		for _, server in ipairs(servers) do
			if lspconfig[server] then
				lspconfig[server].setup({ on_attach = on_attach, capabilities = capabilities })
			end
		end

		-- Setting up lua server
		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
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
		})
	end,
}
