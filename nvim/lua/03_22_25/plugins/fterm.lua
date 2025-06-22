-- ╭─────────────────────────────────────────────────────────╮
-- │ FLOATING TERMINAL: Quick terminal access and sessions  │
-- │ KEY BINDINGS:                                           │
-- │   • <Alt-i> - Toggle terminal (normal + terminal mode)  │
-- │   • <Alt-x> - Close terminal session                   │
-- │   • <C-f>   - Session manager (sesh integration)       │
-- ╰─────────────────────────────────────────────────────────╯

return {
  'numToStr/FTerm.nvim',
  cmd = { 'FTermToggle', 'FTermOpen', 'FTermClose' },
  config = function()
    local fterm = require 'FTerm'
    fterm.setup {}
    vim.keymap.set('n', '<A-i>', function()
      fterm.toggle()
    end, { desc = 'Toggle terminal' })
    vim.keymap.set('t', '<A-i>', function()
      fterm.toggle()
    end, { desc = 'Toggle out of terminal' })
    vim.keymap.set('t', '<A-x>', function()
      fterm.exit()
    end, { desc = 'Close terminal session' })
  end,
}
