-- LSP Configuration & Plugins
-- Note: blink.cmp completion engine is configured in plugins/blink.lua
return {
  { 'tpope/vim-sleuth' },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'j-hui/fidget.nvim', opts = {} },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
          map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')
          map('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>sws', require('fzf-lua').lsp_live_workspace_symbols, '[S]earch [W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame variable')
          map('<leader>ce', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

      local servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                venvPath = '/Users/aaronmikulka/code/january/src',
                venv = '.venv',
                extraPaths = {
                  '/Users/aaronmikulka/code/january/src',
                  '/Users/aaronmikulka/code/january/src/apps/chocolate',
                  '/Users/aaronmikulka/code/january/src/apps/cmo',
                  '/Users/aaronmikulka/code/january/src/apps/debtsy',
                  '/Users/aaronmikulka/code/january/src/apps/temporal',
                  '/Users/aaronmikulka/code/january/src/libs/cmo-messaging',
                  '/Users/aaronmikulka/code/january/src/libs/comms-engine-redis',
                  '/Users/aaronmikulka/code/january/src/libs/debtsy-db',
                  '/Users/aaronmikulka/code/january/src/libs/ml-outputs-db',
                  '/Users/aaronmikulka/code/january/src/libs/temporal-client',
                  '/Users/aaronmikulka/code/january/src/libs/snowflake-connector',
                  '/Users/aaronmikulka/code/january/src/utils',
                  '/Users/aaronmikulka/code/january/src/domains',
                  '/Users/aaronmikulka/code/january/src/models',
                  '/Users/aaronmikulka/code/january/src/devx',
                },
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
                diagnosticMode = 'workspace',
                typeCheckingMode = 'basic',
              },
            },
          },
          root_dir = function(fname)
            local util = require 'lspconfig.util'
            return util.root_pattern('pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git')(fname) or util.path.dirname(fname)
          end,
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'prettier',
        'ruff',
        'isort',
        'markdownlint',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    opts = {
      settings = {
        complete_function_calls = true,
        jsx_close_tag = {
          enable = true,
          filetypes = { 'typescriptreact', 'javascriptreact' },
        },
      },
    },
  },
}
