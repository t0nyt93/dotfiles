return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-macchiato")
		end,
	},
	{ "sainnhe/edge", lazy = true },
	{ "EdenEast/nightfox.nvim", lazy = true },
}
