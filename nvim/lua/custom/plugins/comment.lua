return {
  { 'JoosepAlviste/nvim-ts-context-commentstring', opts = {} },
  {

    'numToStr/Comment.nvim',
    config = function(opts, _)
      vim.keymap.set('n', '<leader>/', function()
        require('Comment.api').toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
      end, { desc = 'Toggle comment line' })
      vim.keymap.set(
        'v',
        '<leader>/',
        "<esc><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>",
        { desc = 'Toggle comment for selection' }
      )
      opts.pre_hook = function()
        return require('ts_context_commentstring.internal').calculate_commentstring()
      end
      require('Comment').setup(opts)
    end,
  },
}
