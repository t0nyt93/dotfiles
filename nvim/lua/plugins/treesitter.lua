return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{ "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 3 } },
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "tsx", "jsx", "xml" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
