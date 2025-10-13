return {
  { 'tpope/vim-sleuth' },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      { 'ms-jpq/coq_nvim', branch = 'coq' },
      { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
      { 'ms-jpq/coq.thirdparty', branch = '3p' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'j-hui/fidget.nvim', opts = {} },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    },
    init = function()
      vim.g.coq_settings = {
        auto_start = 'shut-up',
        display = { preview = { positions = { north = 3, south = 2, west = 4, east = 1 } } },
      }
    end,
    config = function()
      local coq = require 'coq'
      require('mason').setup()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, coq.lsp_ensure_capabilities())
      local servers = {}

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- Formatters
        'stylua', -- Lua formatter
        'prettier', -- JS/TS/JSON/YAML/Markdown formatter
        'ruff', -- Python formatter and linter
        'isort', -- Python import sorter
        -- Linters
        'markdownlint', -- Markdown linter
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
