-- ╭─────────────────────────────────────────────────────────╮
-- │ AUTOCOMMANDS: Automatic behaviors and event handlers   │
-- │ FEATURES: Yank highlighting, auto-lint                 │
-- │ PERFORMANCE: Optimized timing and conflict avoidance   │
-- │ NOTE: Auto-format is handled by conform.nvim plugin    │
-- ╰─────────────────────────────────────────────────────────╯

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
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
