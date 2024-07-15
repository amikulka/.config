vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = '[P]roject [V]iew' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without overwriting clipboard' })

-- This is going to get me cancelled
vim.keymap.set('i', '<C-c>', '<Esc>')

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<leader>=', vim.lsp.buf.format, { desc = 'Format buffer' })

vim.keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]eplace [W]ord' })
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Make file executable' })

vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Write buffer' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit buffer' })
vim.keymap.set('n', '<leader>Q', ':q!<CR>', { desc = 'Force quit buffer' })

-- Separate clipboard for yank and paste
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<M-c>', [["+y]], { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank to system clipboard' })

-- -- greatest remap ever
-- vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without overwriting clipboard' })
