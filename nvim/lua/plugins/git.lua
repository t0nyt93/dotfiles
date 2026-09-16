return {
	{ "tpope/vim-fugitive" },
	{ "ruanyl/vim-gh-line" },
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
		keys = {
			{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview: open (working tree)" },
			{ "<leader>gm", "<cmd>DiffviewOpen origin/main...HEAD<cr>", desc = "Diffview: diff vs origin/main" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: file history (current file)" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: repo history" },
			{ "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview: close" },
		},
		opts = {},
	},
}
