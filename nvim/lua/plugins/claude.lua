return {
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<Leader>ac", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
			{ "<Leader>aa", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude terminal" },
		},
	},
}
