return {
  "EdenEast/nightfox.nvim",
  lazy = false,    -- Load this immediately on startup
  priority = 1000, -- Load this before all other plugins
  config = function()
    vim.cmd.colorscheme("nightfox")
  end,
}
