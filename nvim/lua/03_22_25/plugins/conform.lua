-- ╭─────────────────────────────────────────────────────────╮
-- │ CONFORM: Code formatting with multiple formatters       │
-- │ KEY BINDINGS:                                           │
-- │   • <leader>=   - Format current buffer                 │
-- │   • <leader>taf - Toggle auto-format on save            │
-- │   • <leader>tai - Toggle isort for Python files         │
-- │ DEPENDENCIES: stylua, ruff, prettier, isort (auto)     │
-- ╰─────────────────────────────────────────────────────────╯

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre', 'BufNewFile' },
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = function()
          local formatters = {}
          if vim.g.isort_enabled then
            table.insert(formatters, 'isort')
          end
          table.insert(formatters, 'ruff_format')
          return formatters
        end,
        typescript = { 'prettier' },
        javascript = { 'prettier' },
        typescriptreact = { 'prettier' },
        javascriptreact = { 'prettier' },
        json = { 'prettier' },
        graphql = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
      },
      formatters = {
        prettier = {
          command = vim.fn.executable('prettier') and 'prettier' or vim.fn.stdpath('data') .. '/mason/bin/prettier',
          condition = function()
            return vim.fn.executable('prettier') == 1 or vim.fn.executable(vim.fn.stdpath('data') .. '/mason/bin/prettier') == 1
          end,
        },
        ruff_format = {
          command = vim.fn.executable('ruff') and 'ruff' or vim.fn.stdpath('data') .. '/mason/bin/ruff',
          args = { 'format', '--quiet', '-' },
          condition = function()
            return vim.fn.executable('ruff') == 1 or vim.fn.executable(vim.fn.stdpath('data') .. '/mason/bin/ruff') == 1
          end,
        },
        isort = {
          command = vim.fn.executable('isort') and 'isort' or vim.fn.stdpath('data') .. '/mason/bin/isort',
          condition = function()
            return vim.fn.executable('isort') == 1 or vim.fn.executable(vim.fn.stdpath('data') .. '/mason/bin/isort') == 1
          end,
        },
        stylua = {
          command = vim.fn.executable('stylua') and 'stylua' or vim.fn.stdpath('data') .. '/mason/bin/stylua',
          condition = function()
            return vim.fn.executable('stylua') == 1 or vim.fn.executable(vim.fn.stdpath('data') .. '/mason/bin/stylua') == 1
          end,
        },
      },
    }
  end,
}
