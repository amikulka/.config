-- ╭─────────────────────────────────────────────────────────╮
-- │ KEY MAPPINGS: Custom keybinds and workflow shortcuts   │
-- │ PHILOSOPHY: Leader-based, mnemonic, conflict-free      │
-- │ FEATURES: Smart navigation, clipboard, formatting      │
-- │ INTEGRATIONS: LSP, session management, terminal        │
-- ╰─────────────────────────────────────────────────────────╯

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = '[P]roject [V]iew' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv") -- move highlighted line(s) down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv") -- move highlighted line(s) up

vim.keymap.set('n', 'J', 'mzJ`z') -- join lines without moving cursor
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- move cursor down half a page and center it
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- move cursor up half a page and center it
vim.keymap.set('n', 'G', 'Gzz') -- move to end of file and center it
vim.keymap.set('n', 'n', 'nzzzv') -- move to next search result and center it
vim.keymap.set('n', 'N', 'Nzzzv') -- move to previous search result and center it

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without overwriting clipboard' })

vim.keymap.set('i', '<C-c>', '<Esc>') -- exit insert mode with <C-c>

vim.keymap.set('n', 'Q', '<nop>') -- disable Ex mode
vim.keymap.set('n', '<leader>=', vim.lsp.buf.format, { desc = 'Format buffer' })

-- replace word under cursor
vim.keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]eplace [W]ord' })
-- Make file executable
-- vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Make file executable' })

vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Write buffer' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit buffer' })
vim.keymap.set('n', '<leader>Q', ':q!<CR>', { desc = 'Force quit buffer' })

-- Separate clipboard for yank and paste
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<M-c>', [["+y]], { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank to system clipboard' })


vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- clear search highlights with <Esc>

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })


vim.api.nvim_set_keymap(
  'n',
  '<leader>taf',
  '<cmd>lua vim.g.autoformat_enabled = not vim.g.autoformat_enabled; print("Autoformat is now " .. (vim.g.autoformat_enabled and "enabled" or "disabled"))<CR>',
  { noremap = true, silent = true, desc = '[T]oggle Auto[F]ormat' }
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>tai',
  '<cmd>lua vim.g.isort_enabled = not vim.g.isort_enabled; print("Isort is now " .. (vim.g.isort_enabled and "enabled" or "disabled"))<CR>',
  { noremap = true, silent = true, desc = '[T]oggle [A]uto [I]sort' }
)

-- Session management with sesh integration
vim.keymap.set('n', '<C-f>', function()
  local fterm = require 'FTerm'
  -- Use sesh with fzf for smart session management
  fterm.run([[
    session=$(sesh list | fzf --prompt="Session: " --height=40% --reverse --border)
    if [ -n "$session" ]; then
      sesh connect "$session"
    fi
    exit
  ]])
end, { desc = 'Open session manager' })
