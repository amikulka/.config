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
        adapters = {
          anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {
              env = {
                api_key = 'cmd: gpg --batch --quiet --decrypt ~/.config/keys/anthropic_key.gpg',
              },
            })
          end,
        },
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
        opts = {
          log_level = 'ERROR',
        },
        extensions = {
          vectorcode = {
            opts = {
              add_tool = true,
            },
          },
        },
      }

      vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat<cr>', { desc = 'Code [C]ompanion [C]hat' })
      vim.keymap.set('n', '<leader>ci', '<cmd>CodeCompanion<cr>', { desc = 'Code [C]ompanion [I]nline' })
      vim.keymap.set('n', '<leader>ca', '<cmd>CodeCompanionActions<cr>', { desc = 'Code [C]ompanion [A]ctions' })
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
