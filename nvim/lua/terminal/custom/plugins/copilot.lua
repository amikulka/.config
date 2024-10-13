return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    cmd = 'Copilot',
    config = function()
      require('copilot').setup {
        suggestion = {
          auto_trigger = true,
        },
      }
      vim.api.nvim_set_hl(0, 'CopilotSuggestion', { fg = '#c19a6b' })
    end,
  },
}
