return {
  'ahmedkhalf/project.nvim',
  config = function()
    local project = require 'project_nvim'
    project.setup {
      detection_methods = { 'pattern', 'lsp' },
      patterns = { 'pyproject.toml', 'package.json', '.git' },
      silent_chdir = true,
    }
    vim.keymap.set('n', '<C-f>', function()
      require('telescope').extensions.projects.projects()
    end, { desc = 'find project files' })
  end,
}
