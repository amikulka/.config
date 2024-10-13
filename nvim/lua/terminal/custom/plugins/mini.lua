return { -- Collection of various small independent plugins/modules
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
    end,
  },
  {
    'echasnovski/mini.nvim',
    config = function()
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

      require('mini.surround').setup()
      require('mini.comment').setup {
        mappings = {
          comment = 'gc',
          comment_line = '<leader>/',
          comment_visual = '<leader>/',
          textobject = 'gc',
        },
      }
      require('mini.pairs').setup()
    end,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },
}
