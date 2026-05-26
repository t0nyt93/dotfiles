-- ========================================================================== --
-- 1. GLOBAL INITIALIZATION & BOOTSTRAP                                       --
-- ========================================================================== --
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Load your basic lazy bootstrap if you have one inside config/lazy
pcall(require, "config.lazy")

-- ========================================================================== --
-- 2. SINGLE PLUGINS CONFIGURATION                                            --
-- ========================================================================== --
require("lazy").setup({
	-- Themes and UI
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-macchiato")
		end,
	},
	{ "sainnhe/edge" },
	{ "EdenEast/nightfox.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup()
		end,
	},

	-- Fuzzy Finder (Telescope)
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

	-- Git and Utilities
	{ "tpope/vim-fugitive" },
	{ "ruanyl/vim-gh-line" },
	{ "folke/snacks.nvim" },
	{ "moll/vim-bbye" },

	-- Native LSP Infrastructure
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" }, -- Provides default data configs for Neovim core [1]
	{ "stevearc/conform.nvim" },

	-- Native Completion Engine (Replaces CoC Popups)
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			-- This block now safely runs ONLY after the plugin is loaded
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim-lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	-- Treesitter (Syntax)
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{ "nvim-treesitter/nvim-treesitter-context" },

	-- Vim Scripts and Legacy Plugins
	{ "vim-scripts/CycleColor" },
	{ "preservim/nerdtree" },
	{ "jiangmiao/auto-pairs" },
	{ "JamshedVesuna/vim-markdown-preview" },
})

-- ========================================================================== --
-- 3. NATIVE LSP & MASON CONFIGURATION (Neovim 0.11 System)                   --
-- ========================================================================== --
require("mason").setup()
require("mason-lspconfig").setup({
	-- Automatically install these servers via Mason
	ensure_installed = { "lua_ls", "pyright", "ts_ls" },
})

-- Neovim 0.11 native server configuration [1]
vim.lsp.config("lua_ls", {
	settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})
vim.lsp.config("pyright", {})
vim.lsp.config("ts_ls", {})

-- Explicitly activate the servers [1]
vim.lsp.enable({ "lua_ls", "pyright", "ts_ls" })

-- ========================================================================== --
-- 4. NVIM-CMP COMPLETION SETUP (The new popup logic)                        --
-- ========================================================================== --

-- ========================================================================== --
-- 5. GLOBAL OPTIONS & CORE SETTINGS                                          --
-- ========================================================================== --
vim.opt.termguicolors = true
vim.opt.backupcopy = "yes"
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.encoding = "utf-8"
vim.opt.updatetime = 2000
vim.opt.relativenumber = true
vim.opt.foldmethod = "indent"
vim.opt.foldcolumn = "1"
vim.opt.foldlevelstart = 99
vim.opt.listchars = { tab = "| " }
vim.opt.list = true

vim.opt.wildignore:append({
	"*/.git/*",
	"*/.idea/*",
	"*/.DS_Store/*",
	"*/node_modules/*",
	"*/coverage/*",
	"*/cdk.out/*",
})

-- Markdown settings
vim.g.vim_markdown_preview_github = 1
vim.g.vim_markdown_preview_browser = "Brave Browser"
vim.g.mkdp_echo_preview_url = 1
vim.g.vim_markdown_preview_hotkey = "<C-m>"

-- ========================================================================== --
-- 6. CUSTOM KEYMAPPINGS (Including Native LSP Remaps)                       --
-- ========================================================================== --
local map = vim.keymap.set
local opts = { silent = true }

-- Buffer & Window Actions
map("n", "<Leader>q", ":Bdelete<CR>", opts)
map("n", "<Leader>bn", ":bn<CR>", opts)
map("n", "<Leader>bb", ":bp<CR>", opts)
map("n", "<Leader>bp", ":b#<CR>", opts)
map("n", "<Leader>l", ":ls<CR>", opts)
map("n", "<Leader>bc", ":bp|bd #<CR>", opts)
map("t", "<Leader>w", "<C-w>w", opts)
map("n", "<Leader>w", "<C-w>w", opts)

-- Utility Lists & Navigation
map("n", "<Leader>co", ":copen<CR>", opts)
map("n", "<Leader>cc", ":cclose<CR>", opts)
map("n", "<Leader>f", ':lua require("conform").format()<CR>', opts)
map("n", "<Leader>t", ":NERDTreeToggle<CR>", opts)
map("n", ":W", ":w")

-- Telescope
map("n", "<Leader>p", "<cmd>Telescope git_files<CR>", opts)
map("n", "<Leader>b", "<cmd>Telescope buffers<CR>", opts)
map("n", "<Leader>c", "<cmd>Telescope commands<CR>", opts)
map("n", "<Leader>h", "<cmd>Telescope git_commits<CR>", opts)
map("n", "<Leader>s", "<cmd>Telescope live_grep<CR>", opts)
map("n", "<Leader>ss", "<cmd>Telescope grep_string<CR>", opts)
map("v", "<Leader>ss", '"zy<cmd>Telescope grep_string search=<C-r>z<CR>', opts)
map("n", "<Leader>gb", ":Git blame<CR>", opts)

-- Native LSP Event Keymaps (Replaces CoC mappings dynamically when LSP connects) [1]
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local map_opts = { buffer = bufnr, silent = true }

		map("n", "gd", vim.lsp.buf.definition, map_opts)
		map("n", "gt", vim.lsp.buf.type_definition, map_opts)
		map("n", "gi", vim.lsp.buf.implementation, map_opts)

		map("n", "gr", vim.lsp.buf.references, map_opts)
		map("n", "<Leader>A", vim.diagnostic.goto_next, map_opts)

		-- Native documentation hover (Replaces your complex legacy VimScript functions) [1]
		map("n", "K", vim.lsp.buf.hover, map_opts)
	end,
})
