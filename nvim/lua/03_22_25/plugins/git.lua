-- ╭─────────────────────────────────────────────────────────╮
-- │ GIT INTEGRATION: Signs, blame, and LazyGit terminal UI  │
-- │ KEY BINDINGS:                                           │
-- │   • <leader>gg - Open LazyGit                          │
-- │   • <leader>gf - LazyGit for current file              │
-- │   • <leader>tg - Toggle Git Blame                      │
-- │ FEATURES: Gutter signs, inline blame, LazyGit UI       │
-- ╰─────────────────────────────────────────────────────────╯

return {
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>gg', '<cmd>LazyGit<CR>', desc = 'Open lazy[G]it' },
      { '<leader>gf', '<cmd>LazyGitCurrentFile<CR>', desc = 'Open lazy[G]it for current file' },
    },
  },
  {
    'f-person/git-blame.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('gitblame').setup {
        enabled = true,
        message_template = ' <summary> • <date> • <author>',
        date_format = '%c',
        highlight_group = 'GitBlameVirtText',
      }
      -- Define custom highlight group for git blame
      vim.api.nvim_set_hl(0, 'GitBlameVirtText', {
        fg = '#555555',
        italic = true,
        bold = false,
      })
    end,
    keys = {
      { '<leader>tg', '<cmd>GitBlameToggle<CR>', desc = '[T]oggle [G]it Blame' },
    },
  },
}
