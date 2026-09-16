vim.opt.termguicolors = true
vim.opt.backupcopy = "yes"
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.encoding = "utf-8"
vim.opt.updatetime = 250
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

vim.g.vim_markdown_preview_github = 1
vim.g.vim_markdown_preview_browser = "Google Chrome"
vim.g.mkdp_echo_preview_url = 1
-- Disable the plugin's built-in hotkey; bound via <F5> in keymaps.lua.
-- (Avoids <C-m>, which is indistinguishable from <CR>/Enter in a terminal.
--  Empty string would break the plugin's startup autocmd, so use a <Plug> no-op.)
vim.g.vim_markdown_preview_hotkey = "<Plug>NoMarkdownPreviewHotkey"
