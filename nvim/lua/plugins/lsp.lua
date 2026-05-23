-- ╭─────────────────────────────────────────────────────────╮
-- │ LSP: vim.lsp.config (0.11+) + mason-lspconfig v2         │
-- │ COMPLETION: blink.cmp (configured in plugins/blink.lua)  │
-- │ SERVERS: pyright, lua_ls, vtsls                          │
-- ╰─────────────────────────────────────────────────────────╯

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
      { 'mason-org/mason.nvim' },
      { 'mason-org/mason-lspconfig.nvim' },
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
          if client and client:supports_method('textDocument/documentHighlight') then
            local highlight_group = vim.api.nvim_create_augroup('lsp-highlight-' .. event.buf, { clear = true })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_group,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

      vim.lsp.config('*', { capabilities = capabilities })

      vim.lsp.config('basedpyright', {
        root_markers = { 'pyrightconfig.json', 'pyproject.toml', '.git' },
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
          },
        },
      })

      vim.lsp.config('vtsls', {
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = 'literals' },
              variableTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
          javascript = {
            inlayHints = {
              parameterNames = { enabled = 'literals' },
            },
          },
          vtsls = {
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = { enableServerSideFuzzyMatch = true },
            },
          },
        },
      })

      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = { 'basedpyright', 'lua_ls', 'vtsls' },
        automatic_enable = true,
      }
      require('mason-tool-installer').setup {
        ensure_installed = { 'stylua', 'prettier', 'ruff', 'markdownlint' },
      }
    end,
  },
}
