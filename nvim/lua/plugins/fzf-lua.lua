return {
  'ibhagwan/fzf-lua',
  event = 'VimEnter',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local fzf = require 'fzf-lua'

    fzf.setup {
      'default',
      winopts = {
        height = 0.85,
        width = 0.85,
        row = 0.35,
        col = 0.50,
        preview = {
          default = 'builtin',
          horizontal = 'right:50%',
          layout = 'flex',
        },
      },
      files = {
        cwd_prompt = false,
        prompt = 'Files❯ ',
      },
      grep = {
        prompt = 'Grep❯ ',
        no_header_i = true,
        actions = {
          ['ctrl-g'] = false,
        },
      },
      keymap = {
        builtin = {
          ['<C-/>'] = 'toggle-help',
          ['<C-d>'] = 'preview-page-down',
          ['<C-u>'] = 'preview-page-up',
        },
        fzf = {
          ['ctrl-j'] = 'down',
          ['ctrl-k'] = 'up',
          ['ctrl-d'] = 'preview-page-down',
          ['ctrl-u'] = 'preview-page-up',
        },
      },
      lsp = {
        symbols = { symbol_style = 1 },
        code_actions = { previewer = 'codeaction_native' },
      },
      defaults = {
        formatter = 'path.filename_first',
      },
    }

    fzf.register_ui_select()

    vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>st', fzf.builtin, { desc = '[S]earch fzf-lua builtins' })
    vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', fzf.diagnostics_workspace, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s<enter>', fzf.oldfiles, { desc = '[S]earch Recent Files' })
    vim.keymap.set('n', '<leader>sb', fzf.buffers, { desc = '[S]earch existing [B]uffers' })

    vim.keymap.set('n', '<leader>s.', function()
      fzf.lgrep_curbuf { winopts = { preview = { hidden = 'hidden' } } }
    end, { desc = 'Search current buffer (file)' })

    vim.keymap.set('n', '<leader>s/', fzf.lines, { desc = '[S]earch [/] in Open Buffers' })

    vim.keymap.set('n', '<leader>sn', function()
      fzf.files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
