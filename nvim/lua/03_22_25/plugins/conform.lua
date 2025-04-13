return { -- Autoformat
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup {
      -- Your other configuration settings
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'ruff_format' },
        typescript = { 'prettier' },
        javascript = { 'prettier' },
        typescriptreact = { 'prettier' },
        javascriptreact = { 'prettier' },
        -- yaml = { 'prettier' },
        json = { 'prettier' },
        graphql = { 'prettier' },
        gitcommit = { 'ltex-ls' },
        -- Add more formatters as needed
      },
      formatters = {
        prettier = {
          -- Change where to find the command
          command = '/opt/homebrew/bin/prettier',
        },
        ruff_format = {
          command = vim.fn.executable 'ruff' and 'ruff' or '/opt/homebrew/bin/ruff',
          args = { 'format', '--quiet', '-' },
        },
      },
      -- Leave format_on_save disabled here or set it based on a global variable
      -- format_on_save = {
      --   -- I recommend these options. See :help conform.format for details.
      --   lsp_fallback = true,
      --   timeout_ms = 700,
      -- },
      -- format_after_save = {
      --   lsp_fallback = true,
      --   timeout_ms = 4000,
      -- },
    }
  end,
}
