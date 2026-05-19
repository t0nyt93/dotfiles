-- In your Neovim config (e.g., ~/.config/nvim/lua/lsp/homeassistant.lua)
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

-- Define the custom server
if not configs.homeassistant then
  configs.homeassistant = {
    default_config = {
      cmd = { 'homeassistant-lsp', '--stdio' },
      filetypes = { 'yaml', 'yaml.homeassistant', 'python' },
      root_dir = lspconfig.util.root_pattern('.git', 'configuration.yaml'),
      settings = {
        homeassistant = {
          host = 'ws://homeassistant.local:8123/api/websocket',
          token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIyYWY5MmQ1OTQ3ODU0ZjliOTVmZmI1MzhjMjA4NmM4NyIsImlhdCI6MTc3OTE1MzAxOCwiZXhwIjoyMDk0NTEzMDE4fQ.VnKrcsuhTIYDxL4gX4p10bJpr6c9joRzHxbcO9vzem4',
        },
      },
    },
  }
end

-- Setup the server
lspconfig.homeassistant.setup({
  on_attach = function(client, bufnr)
    -- Your on_attach function
  end,
})
