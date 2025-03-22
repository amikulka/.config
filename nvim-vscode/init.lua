require('nvim-vscode.config.options')
require('nvim-vscode.config.mappings')
require('nvim-vscode.config.vscode-map')

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)



require('lazy').setup({
  { import = 'nvim-vscode.plugins' },
})
