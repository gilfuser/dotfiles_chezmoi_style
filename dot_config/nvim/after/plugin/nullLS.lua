---------------------------------
-- Formatação
---------------------------------
local diagnostics = require("null-ls").builtins.diagnostics
local formatting = require("null-ls").builtins.formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local h = require("null-ls.helpers")
local cmd_resolver = require("null-ls.helpers.command_resolver")
local methods = require("null-ls.methods")
local u = require("null-ls.utils")
-- local FORMATTING = methods.internal.FORMATTING

require("null-ls").setup({
	sources = {
		formatting.black,
		-- formatting.rustfmt,
		-- formatting.phpcsfixer,
		-- formatting.prettier,
		formatting.stylua,
	},
	on_attach = function(client, bufnr)
		if client.name == "tsserver" or client.name == "rust_analyzer" or client.name == "pyright" then
			client.resolved_capabilities.document_formatting = false
		end

		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				-- buffer = bufnr,
				callback = function()
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
})

---------------------------------
-- Auto commands
---------------------------------
vim.cmd([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]])
