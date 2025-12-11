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
        python = { 'ruff_format' },
        typescript = { 'prettier' },
        javascript = { 'prettier' },
        typescriptreact = { 'prettier' },
        javascriptreact = { 'prettier' },
        json = { 'prettier' },
        graphql = { 'prettier' },
        markdown = { 'prettier' },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = 'fallback' }
      end,
    }
    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })
    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })

    -- Keymap to toggle autoformat
    vim.keymap.set('n', '<leader>taf', function()
      if vim.g.disable_autoformat or vim.b.disable_autoformat then
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
        vim.notify('Autoformat enabled', vim.log.levels.INFO)
      else
        vim.g.disable_autoformat = true
        vim.notify('Autoformat disabled', vim.log.levels.INFO)
      end
    end, { desc = 'Toggle autoformat on save' })
  end,
}
