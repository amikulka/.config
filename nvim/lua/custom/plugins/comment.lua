return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      vim.keymap.set('n', '<leader>/', function()
        require('Comment.api').toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
      end, { desc = 'Toggle comment line' })
      vim.keymap.set(
        'v',
        '<leader>/',
        "<esc><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>",
        { desc = 'Toggle comment for selection' }
      )
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
}
