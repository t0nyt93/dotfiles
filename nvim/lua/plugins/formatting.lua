-- lua/plugins/formatting.lua
return {
	-- 1. Ensure the tools are downloaded via Mason
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua", -- Formatter for Lua
				"prettier", -- Formatter for JS/TS/HTML/CSS/Markdown
				"eslint_d", -- Fast ESLint daemon for --fix (import sorting etc.)
				"clang-format", -- Formatter for C/C++
			},
		},
	},

	-- 2. Setup Auto-Formatting (conform.nvim)
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" }, -- Run right before saving a file
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier", "eslint_d" },
					javascriptreact = { "prettier", "eslint_d" },
					typescript = { "prettier", "eslint_d" },
					typescriptreact = { "prettier", "eslint_d" },
					json = { "prettier" },
					markdown = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					c = { "clang-format" },
					cpp = { "clang-format" },
				},
				-- Automatically format when you save the file
				format_on_save = {
					timeout_ms = 2000,
					lsp_format = "fallback",
				},
			})
		end,
	},
}
