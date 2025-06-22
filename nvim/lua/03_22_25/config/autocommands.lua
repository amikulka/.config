-- ╭─────────────────────────────────────────────────────────╮
-- │ AUTOCOMMANDS: Automatic behaviors and event handlers   │
-- │ FEATURES: Yank highlighting, auto-format, auto-lint    │
-- │ PERFORMANCE: Optimized timing and conflict avoidance   │
-- │ TOGGLES: Respects user preferences and manual overrides│
-- ╰─────────────────────────────────────────────────────────╯

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto-format on save (respects toggle)
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    if vim.g.autoformat_enabled then
      require('conform').format { bufnr = args.buf, timeout_ms = 2000, lsp_format = 'fallback' }
    end
  end,
})

-- Auto-lint on save and insert leave
vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave', 'BufEnter' }, {
  callback = function()
    -- Delay linting slightly to avoid conflicts with formatting
    vim.defer_fn(function()
      require('lint').try_lint()
    end, 100)
  end,
})
