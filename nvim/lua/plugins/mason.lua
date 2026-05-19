return {
  -- 1. Main Mason Plugin
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- 2. Bridge between Mason and nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        -- Put any language servers you want auto-installed here
        ensure_installed = { "lua_ls" }, 
      })
    end,
  },

  -- 3. Neovim LSP Configurator (Updated for Neovim 0.11+)
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      -- Do NOT use require("lspconfig") or .setup() here anymore!

      -- Tell Neovim to modify the default 'lua_ls' configuration data
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              -- Stop Lua from complaining about the 'vim' global variable
              globals = { "vim" },
            },
          },
        },
      })

      -- Explicitly activate the server
      vim.lsp.enable("lua_ls")
    end,
  },
}
