return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    cmd = 'Copilot',
    config = function()
      local copilot = require 'copilot'

      copilot.setup {
        panel = {
          enabled = false,
        },
        suggestion = {
          auto_trigger = true,
          hide_during_completion = false,
        },
        copilot_model = 'gpt-4o-copilot',
      }

      vim.api.nvim_set_hl(0, 'CopilotSuggestion', { fg = '#c19a6b' })
      vim.keymap.set('i', '<C-CR>', function()
        if vim.fn.pumvisible() == 1 then
          vim.cmd 'call feedkeys("\\<C-e>", "n")'
        end
        require('copilot.suggestion').accept()
      end, { desc = 'Accept copilot suggestion' })
    end,
  },
}
