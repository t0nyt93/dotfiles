-- ========================================================================== --
-- 1. LAZY.NVIM BOOTSTRAPPER (Auto-downloads manager if missing)              --
-- ========================================================================== --
---- Note: Mapleader needs to be defined if you use <Leader> keys
vim.g.mapleader = "\\" -- Adjust this if your leader is something else (e.g. ",")
 
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Themes and UI
  { "sainnhe/edge" },
  { "EdenEast/nightfox.nvim" },
  { "catppuccin/nvim", name = "catppuccin" }, -- 'as' becomes 'name'
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- Fuzzy Finder (Telescope)
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Git and Utilities
  { "tpope/vim-fugitive" },
  { "ruanyl/vim-gh-line" },
  { "folke/snacks.nvim" },
  { "moll/vim-bbye" },

  -- Languages and LSP
  { "myakove/homeassistant-nvim" },
  { "neoclide/coc.nvim", branch = "release" }, -- CoC requires the release branch
  { "stevearc/conform.nvim" },

  -- Treesitter (Syntax)
  { 
    "nvim-treesitter/nvim-treesitter", 
    lazy = false,
    build = ":TSUpdate" -- 'do' becomes 'build'
  },
  { "nvim-treesitter/nvim-treesitter-context" },

  -- Vim Scripts and Legacy Plugins
  { "vim-scripts/CycleColor" },
  { "preservim/nerdtree" },
  { "jiangmiao/auto-pairs" },
  { "JamshedVesuna/vim-markdown-preview" },
})

vim.cmd[[colorscheme nightfox]]


-- ========================================================================== --
-- 2. PLUGIN CONFIGURATIONS (Using your ported plugin list)                   --
-- ========================================================================== --
require("lazy").setup({
  -- Themes and UI
  { 
    "catppuccin/nvim", 
    name = "catppuccin",
    lazy = false,    -- Load immediately
    priority = 1000, -- Highest priority for themes
    config = function()
      vim.cmd.colorscheme("catppuccin-macchiato") -- Loads your chosen palette
    end
  },
  { "sainnhe/edge" },
  { "EdenEast/nightfox.nvim" },
  { 
    "nvim-lualine/lualine.nvim", 
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("lualine").setup() end
  },

  -- Fuzzy Finder (Telescope)
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Git and Utilities
  { "tpope/vim-fugitive" },
  { "ruanyl/vim-gh-line" },
  { "folke/snacks.nvim" },
  { "moll/vim-bbye" },

  -- Languages and LSP
  { "myakove/homeassistant-nvim" },
  { "neoclide/coc.nvim", branch = "release" },
  { "stevearc/conform.nvim" },

  -- Treesitter (Syntax)
  { 
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate"
  },
  { "nvim-treesitter/nvim-treesitter-context" },

  -- Vim Scripts and Legacy Plugins
  { "vim-scripts/CycleColor" },
  { "preservim/nerdtree" },
  { "jiangmiao/auto-pairs" },
  { "JamshedVesuna/vim-markdown-preview" },
})

-- ========================================================================== --
-- 3. GLOBAL OPTIONS & CORE SETTINGS (set/let replacements)                   --
-- ========================================================================== --
vim.opt.termguicolors = true   -- Required for modern themes like Catppuccin
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

-- Search exclusion lists (wildignore)
vim.opt.wildignore:append({ "*/.git/*", "*/.idea/*", "*/.DS_Store/*", "*/node_modules/*", "*/coverage/*", "*/cdk.out/*" })

-- Global Variables (let g:)
vim.g.vim_markdown_preview_github = 1
vim.g.vim_markdown_preview_browser = "Brave Browser"
vim.g.mkdp_echo_preview_url = 1
vim.g.vim_markdown_preview_hotkey = "<C-m>"
vim.g.coc_node_args = { "--max-old-space-size=4096" }
vim.g.coc_global_extensions = { "coc-tsserver", "coc-prettier", "coc-eslint" }
vim.g.coc_disable_transparent_cursor = 1

-- ========================================================================== --
-- 4. CUSTOM KEYMAPPINGS (nnoremap / inoremap replacements)                  --
-- ========================================================================== --

local map = vim.keymap.set
local opts = { silent = true }

-- Buffer Actions
map("n", "<Leader>q", ":Bdelete<CR>", opts)
map("n", "<Leader>bn", ":bn<CR>", opts)
map("n", "<Leader>bb", ":bp<CR>", opts)
map("n", "<Leader>bp", ":b#<CR>", opts)
map("n", "<Leader>l", ":ls<CR>", opts)
map("n", "<Leader>bc", ":bp|bd #<CR>", opts)

-- Window Actions & Navigation
map("t", "<Leader>w", "<C-w>w", opts)
map("n", "<Leader>w", "<C-w>w", opts)

-- Quickfix Lists
map("n", "<Leader>co", ":copen<CR>", opts)
map("n", "<Leader>cc", ":cclose<CR>", opts)

-- Formatting (Conform.nvim)
map("n", "<Leader>f", ':lua require("conform").format()<CR>', opts)

-- NerdTree
map("n", "<Leader>t", ":NERDTreeToggle<CR>", opts)

-- Help out future Tony when he fat fingers save.
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

-- CoC Specific Core Maps
map("n", "<Leader>vo", "<Plug>(coc-terminal-toggle)", opts)
map("n", "gd", "<Plug>(coc-definition)", opts)
map("n", "gt", "<Plug>(coc-type-definition)", opts)
map("n", "gi", "<Plug>(coc-implementation)", opts)
map("n", "gr", "<Plug>(coc-references)", opts)
map("n", "<Leader>A", "<Plug>(coc-diagnostic-next)", opts)

-- CoC Completion (Insert Mode Expressions)
map("i", "<CR>", [[coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"]], { expr = true, silent = true })
map("i", "<Tab>", [[coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"]], { expr = true })
map("i", "<S-Tab>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"]], { expr = true })
map("i", "<C-.>", [[coc#refresh()]], { expr = true, silent = true })

-- ========================================================================== --
-- 5. USER COMMANDS & COMPLEX VIMSCRIPT LOGIC                                 --
-- ========================================================================== --
-- Custom CoC Commands
vim.api.nvim_create_user_command("Tsc", "call CocAction('runCommand', 'tsserver.watchBuild')", {})

-- CoC Documentation Hover Setup
map("n", "K", ":call ShowDocumentation()<CR>", opts)
vim.cmd([[
  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction
]])

-- Alternative Documentation Map (A)
map("n", "A", ":call ShowDocumentationAlt()<CR>", opts)
vim.cmd([[
  function! ShowDocumentationAlt()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute 'h '.expand('<cword>')
    endif
  endfunction
]])

-- ========================================================================== --
-- 6. AUTOCOMMANDS & DESIGN HIGHLIGHTS                                        --
-- ========================================================================== --
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Auto reload configuration changes (Now targets modern init.lua)
local reload_group = augroup("ConfigReload", { clear = true })
autocmd("BufWritePost", {
  pattern = "init.lua",
  command = "source %",
  group = reload_group,
})

-- External change updates
local checktime_group = augroup("ExternalChanges", { clear = true })
autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  command = "checktime",
  group = checktime_group,
})

-- Custom Filetypes
local filetype_group = augroup("CustomFiletypes", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.tsx", "*.jsx" },
  command = "set filetype=typescriptreact",
  group = filetype_group,
})

-- Indentation defaults for YAML files
autocmd("FileType", {
  pattern = { "yaml", "yml" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
  group = filetype_group,
})

-- Highlight Customizations
vim.cmd([[
  highlight LineNr ctermfg=lightblue
  highlight CocErrorHighlight ctermfg=1
  highlight FgCocErrorFloatBgCocFloating ctermfg=1 guifg=#ff0000
  highlight CocWarningHighlight ctermfg=10
  highlight FgCocWarningFloatBgCocFloating ctermfg=3 guifg=#ff0000
  hi link CocFloating Normal
]])

