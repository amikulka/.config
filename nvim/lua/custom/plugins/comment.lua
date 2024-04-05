return {
  'numToStr/Comment.nvim',

  config = function()
    vim.keymap.set('n', '<leader>/', function()
      require('Comment.api').toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
    end, { desc = 'Toggle comment line' })
    vim.keymap.set('v', '<leader>/', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", { desc = 'Toggle comment for selection' })
    require('Comment').setup()
  end,
}
