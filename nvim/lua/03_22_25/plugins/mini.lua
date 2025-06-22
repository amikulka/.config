-- ╭─────────────────────────────────────────────────────────╮
-- │ MINI.NVIM: Swiss army knife of Neovim plugins          │
-- │ KEY BINDINGS:                                           │
-- │   • <leader>/  - Comment line/visual selection          │
-- │   • gc         - Comment operator (e.g., gcc, gcap)     │
-- │   • <leader>f  - File explorer toggle                   │
-- │ FEATURES: Context-aware comments (JSX/TSX support)     │
-- │ MODULES: comment, surround, ai text objects, files     │
-- ╰─────────────────────────────────────────────────────────╯

return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.surround').setup()
      require('mini.comment').setup {
        mappings = {
          comment = 'gc',
          comment_line = '<leader>/',
          comment_visual = '<leader>/',
          textobject = 'gc',
        },
        options = {
          custom_commentstring = function()
            return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
          end,
        },
      }
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

      local MiniFiles = require 'mini.files'
      local minifiles_toggle = function()
        if not MiniFiles.close() then
          MiniFiles.open()
        end
      end
      MiniFiles.setup {
        -- Use `''` (empty string) to not create one.
        mappings = {
          go_in_plus = '<Enter>',
          go_out = 'H',
          go_out_plus = 'h',
        },

        -- General options
        options = {
          -- Whether to use for editing directories
          use_as_default_explorer = false,
        },

        -- Customization of explorer windows
        windows = {
          -- Maximum number of windows to show side by side
          max_number = 5,
          -- Whether to show preview of file/directory under cursor
          preview = true,
          -- Width of focused window
          width_focus = 50,
          -- Width of non-focused window
          width_nofocus = 15,
          -- Width of preview window
          width_preview = 75,
        },
      }
      vim.keymap.set('n', '<leader>f', minifiles_toggle, { desc = 'Open [F]ile Explorer' })
      vim.keymap.set('n', '<leader>f', minifiles_toggle, { desc = 'Open [F]ile Explorer' })

      require('mini.diff').setup {
        view = {
          style = 'sign',
          signs = { add = '+', change = '|', delete = '-' },
        },
      }
    end,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
    end,
  },
}
