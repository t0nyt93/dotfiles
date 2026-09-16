return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "ts_ls", "clangd", "graphql" },
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = { diagnostics = { globals = { "vim" } } },
				},
			})
			vim.lsp.config("pyright", {})
			vim.lsp.config("ts_ls", {})
			vim.lsp.config("clangd", {})
			vim.lsp.config("graphql", {})

			vim.lsp.enable({ "lua_ls", "pyright", "ts_ls", "clangd", "graphql" })

			vim.diagnostic.config({
				virtual_text = { prefix = "●", spacing = 2 },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
			})
		end,
	},
}
