-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    if vim.g.autoformat_enabled then
      require('conform').format { bufnr = args.buf, timeout = 2000 }
    end
  end,
})
--[[ vim.api.nvim_create_augroup('neotree', {})
vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Open Neotree on startup with directory',
  group = 'neotree',
  callback = function()
    local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
    if stats and stats.type == 'directory' then
      require('neo-tree.setup.netrw').hijack()
    end
  end,
}) ]]
