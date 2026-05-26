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

vim.g.vim_markdown_preview_github = 1
vim.g.vim_markdown_preview_browser = "Brave Browser"
vim.g.mkdp_echo_preview_url = 1
vim.g.vim_markdown_preview_hotkey = "<C-m>"
