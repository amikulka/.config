local vscode = require('vscode')

vim.keymap.set('n', '<leader>e', function()
  vscode.action('workbench.action.problems.focus')
end)

vim.keymap.set('n', '<leader>sf', function()
  vscode.action('workbench.action.quickOpen')
end)

vim.keymap.set('n', '<leader>sg', function()
  vscode.action('workbench.view.search')
end)
