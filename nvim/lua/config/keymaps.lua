local map = vim.keymap.set
local opts = { silent = true }

-- Buffer & Window Actions
map("n", "<Leader>q", ":Bdelete<CR>", opts)
map("n", "<Leader>bn", ":bn<CR>", opts)
map("n", "<Leader>bb", ":bp<CR>", opts)
map("n", "<Leader>bp", ":b#<CR>", opts)
map("n", "<Leader>l", ":ls<CR>", opts)
map("n", "<Leader>bc", ":bp|bd #<CR>", opts)
map("t", "<Leader>w", [[<C-\><C-n><C-w>w]], opts)
map("n", "<Leader>w", "<C-w>w", opts)

-- Utility Lists & Navigation
map("n", "<Leader>co", ":copen<CR>", opts)
map("n", "<Leader>cc", ":cclose<CR>", opts)
map("n", "<Leader>f", ':lua require("conform").format()<CR>', opts)
map("n", "<Leader>t", ":NERDTreeToggle<CR>", opts)
map("n", ":W", ":w")

map("n", "<Leader>m", ":Mason <CR>", opts)
map("n", "<F5>", ":call Vim_Markdown_Preview()<CR>", opts)

-- Telescope
map("n", "<Leader>p", "<cmd>Telescope git_files<CR>", opts)
map("n", "<Leader>b", "<cmd>Telescope buffers<CR>", opts)
map("n", "<Leader>c", "<cmd>Telescope commands<CR>", opts)
map("n", "<Leader>h", "<cmd>Telescope git_commits<CR>", opts)
map("n", "<Leader>s", "<cmd>Telescope live_grep<CR>", opts)
map("n", "<Leader>ss", "<cmd>Telescope grep_string<CR>", opts)
map("v", "<Leader>ss", '"zy<cmd>Telescope grep_string search=<C-r>z<CR>', opts)
map("n", "<Leader>gb", ":Git blame<CR>", opts)

-- Native LSP (fires when an LSP server attaches to a buffer)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local map_opts = { buffer = bufnr, silent = true }

		map("n", "gd", vim.lsp.buf.definition, map_opts)
		map("n", "gt", vim.lsp.buf.type_definition, map_opts)
		map("n", "gi", vim.lsp.buf.implementation, map_opts)
		map("n", "gr", vim.lsp.buf.references, map_opts)
		map("n", "<Leader>A", vim.diagnostic.goto_next, map_opts)
		map("n", "]d", vim.diagnostic.goto_next, map_opts)
		map("n", "[d", vim.diagnostic.goto_prev, map_opts)
		map("n", "<Leader>e", vim.diagnostic.open_float, map_opts)
		map("n", "<Leader>ca", vim.lsp.buf.code_action, map_opts)
		map("n", "<Leader>rn", vim.lsp.buf.rename, map_opts)
		map("n", "K", vim.lsp.buf.hover, map_opts)

		map("n", "gv", function()
			vim.lsp.buf.definition({
				on_list = function(options)
					local item = options.items[1]
					vim.cmd("vsplit " .. vim.fn.fnameescape(item.filename))
					vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
				end,
			})
		end, { silent = true })
	end,
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
	end,
})
