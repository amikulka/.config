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

      -- Set up LSP keybindings when LSP attaches to a buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- Helper function for easier keymap definitions
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to definition of word under cursor
          map('gd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for word under cursor
          map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')

          -- Jump to implementation
          map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to type definition
          map('<leader>D', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')

          -- Fuzzy find symbols in current document
          map('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find symbols in workspace
          map('<leader>sws', require('fzf-lua').lsp_live_workspace_symbols, '[S]earch [W]orkspace [S]ymbols')

          -- Rename variable under cursor
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame variable')

          -- Execute code action
          map('<leader>ce', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Show hover documentation
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- Go to declaration (different from definition)
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Highlight references of word under cursor on hold
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
      local servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                -- Point to UV workspace virtual environment
                venvPath = '/Users/aaronmikulka/code/january/src',
                venv = '.venv',
                -- Point to src directories within each workspace member (src-layout pattern)
                -- Analysis settings
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
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- LSP servers
        'pyright', -- Python language server
        'typescript-language-server', -- TypeScript/JavaScript language server
        -- Formatters
        'stylua', -- Lua formatter
        'prettier', -- JS/TS/JSON/YAML/Markdown formatter
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
            require('lspconfig')[server_name].setup(coq.lsp_ensure_capabilities(server))
          end,
        },
      }
    end,
  },
}
