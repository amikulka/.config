return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.comment').setup()
      require('mini.pairs').setup()
      require('mini.surround').setup()
      require('mini.ai').setup {
        n_lines = 500,
        custom_textobjects = {
          f = require('mini.ai').gen_spec.treesitter {
            a = '@function.outer',
            i = '@function.inner',
          },
          c = require('mini.ai').gen_spec.treesitter {
            a = '@class.outer',
            i = '@class.inner',
          },
        },
      }
    end,
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = { enable_autocmd = false },
  },
  {
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
  },
}
