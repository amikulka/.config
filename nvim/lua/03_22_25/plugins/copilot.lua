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
      vim.keymap.set('i', '<c-a>', function()
        if vim.fn.pumvisible() == 1 then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-e>', true, true, true), 'i', false)
        end
        require('copilot.suggestion').accept()
      end, { desc = 'Accept copilot suggestion' })
    end,
  },
}
