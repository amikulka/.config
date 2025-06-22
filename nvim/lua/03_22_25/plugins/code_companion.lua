return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'ravitemer/mcphub.nvim',
    },
    config = function()
      require('codecompanion').setup {
        strategies = {
          chat = {
            adapter = 'anthropic',
            model = 'claude-sonnet-4-20250514',
          },
          inline = {
            adapter = 'anthropic',
            model = 'claude-sonnet-4-20250514',
          },
        },
        extensions = {
          vectorcode = {
            opts = {
              add_tool = true,
            },
          },
        },
      }

      vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat<cr>', { desc = '[C]ode [C]ompanion Chat' })
      vim.keymap.set('n', '<leader>ci', '<cmd>CodeCompanionInline<cr>', { desc = '[C]ode [C]ompanion Inline' })
      vim.keymap.set('n', '<leader>ca', '<cmd>CodeCompanionActions<cr>', { desc = '[C]ode [C]ompanion Actions' })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'codecompanion' },
  },
  {
    'HakonHarnes/img-clip.nvim',
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = '[Image]($FILE_PATH)',
          use_absolute_path = true,
        },
      },
    },
  },
}
