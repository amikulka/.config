return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function() -- This is the function that runs, AFTER loading
    local which_key = require 'which-key'
    which_key.setup()

    which_key.add {
      -- Groups
      { '<leader>c', group = '[C]ode' },
      { '<leader>c_', hidden = true },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>d_', hidden = true },
      { '<leader>p', group = '[P]roject' },
      { '<leader>p_', hidden = true },
      { '<leader>r', group = '[R]ename' },
      { '<leader>r_', hidden = true },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>t_', hidden = true },
      { '<leader>ta', group = '[T]oggle [A]uto' },
      { '<leader>ta_', hidden = true },
      { '<leader>s', group = '[S]earch' },
      { '<leader>s_', hidden = true },
      { '<leader>sw', group = '[S]earch [W]orkspace' },
      { '<leader>sw_', hidden = true },
      { '<leader>g', group = '[G]it' },
      { '<leader>g_', hidden = true },
      { '<leader>h', group = '[H]arpoon' },
      { '<leader>h_', hidden = true },
      { '<leader>x', group = 'Quickfi[X]' },
      { '<leader>x_', hidden = true },

      -- Toggle / Auto
      { '<leader>taf', desc = '[T]oggle [A]uto [F]ormat' },
      { '<leader>tg', desc = '[T]oggle [G]it Blame' },

      -- Project
      { '<leader>pv', desc = '[P]roject [V]iew (netrw)' },

      -- Buffer operations
      { '<leader>w', desc = '[W]rite buffer' },
      { '<leader>q', desc = '[Q]uit buffer' },
      { '<leader>Q', desc = '[Q]uit buffer (force)' },

      -- Clipboard / yank
      { '<leader>y', desc = '[Y]ank to system clipboard' },
      { '<leader>Y', desc = '[Y]ank line to system clipboard' },

      -- Format / lint
      { '<leader>=', desc = 'Format buffer' },
      { '<leader>l', desc = '[L]int current file' },

      -- Diagnostics
      { '<leader>e', desc = 'Show diagnostic [E]rror' },

      -- Code (LSP / Trouble)
      { '<leader>ce', desc = '[C]ode Action' },
      { '<leader>cs', desc = '[C]ode [S]ymbols (Trouble)' },
      { '<leader>cl', desc = '[C]ode [L]SP (Trouble)' },

      -- Document (LSP)
      { '<leader>D', desc = 'Type [D]efinition' },
      { '<leader>ds', desc = '[D]ocument [S]ymbols' },

      -- Rename
      { '<leader>rn', desc = '[R]e[n]ame variable' },
      { '<leader>rw', desc = '[R]eplace [W]ord' },

      -- Search (fzf-lua)
      { '<leader>sh', desc = '[S]earch [H]elp' },
      { '<leader>sk', desc = '[S]earch [K]eymaps' },
      { '<leader>sf', desc = '[S]earch [F]iles' },
      { '<leader>st', desc = '[S]earch fzf-lua builtins' },
      { '<leader>sw', desc = '[S]earch current [W]ord' },
      { '<leader>sg', desc = '[S]earch by [G]rep' },
      { '<leader>sd', desc = '[S]earch [D]iagnostics' },
      { '<leader>sr', desc = '[S]earch [R]esume' },
      { '<leader>sn', desc = '[S]earch [N]eovim config' },
      { '<leader>sb', desc = '[S]earch [B]uffers' },
      { '<leader>s.', desc = '[S]earch current buffer' },
      { '<leader>s/', desc = '[S]earch in open files' },

      -- Search workspace (LSP)
      { '<leader>sws', desc = '[S]earch [W]orkspace [S]ymbols' },

      -- Git
      { '<leader>gg', desc = 'Open Lazy[G]it' },
      { '<leader>gf', desc = 'Open Lazy[G]it (current file)' },

      -- Harpoon
      { '<leader>ha', desc = '[H]arpoon [A]dd file' },

      -- Quickfix / Trouble
      { '<leader>xx', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>xL', desc = '[L]ocation List (Trouble)' },
      { '<leader>xQ', desc = '[Q]uickfix List (Trouble)' },

      -- File / comment
      { '<leader>/', desc = 'Comment line/selection' },
      { '<leader>f', desc = 'Open [F]ile Explorer' },

      -- Avante (AI)
      { '<leader>a', group = '[A]vante AI' },
      { '<leader>a_', hidden = true },
      { '<leader>aa', desc = '[A]sk' },
      { '<leader>an', desc = '[N]ew ask' },
      { '<leader>ae', desc = '[E]dit selection' },
      { '<leader>at', desc = '[T]oggle panel' },
      { '<leader>af', desc = '[F]ocus panel' },
      { '<leader>ar', desc = '[R]efresh' },
      { '<leader>aS', desc = '[S]top request' },
      { '<leader>as', desc = 'Toggle [s]uggestion' },
      { '<leader>aC', desc = 'Toggle sele[C]tion' },
      { '<leader>ad', desc = 'Toggle [d]ebug' },
      { '<leader>az', desc = '[Z]en mode' },
      { '<leader>ac', desc = 'Add [c]urrent buffer to context' },
      { '<leader>aB', desc = 'Add all [B]uffers to context' },
      { '<leader>aR', desc = 'Show [R]epo map' },
      { '<leader>a?', desc = 'Select model' },
      { '<leader>ah', desc = '[H]istory' },

      -- LSP g-prefixed navigation
      { 'g', group = '[G]oto' },
      { 'gd', desc = '[G]oto [D]efinition' },
      { 'gr', desc = '[G]oto [R]eferences' },
      { 'gI', desc = '[G]oto [I]mplementation' },
      { 'gD', desc = '[G]oto [D]eclaration' },
      { 'gc', desc = '[G]o [C]omment (operator)' },
      { 'K', desc = 'Hover [Documentation] (LSP)' },

      -- Bracket navigation
      { '[', group = 'Previous' },
      { ']', group = 'Next' },
      { '[d', desc = 'Previous [D]iagnostic' },
      { ']d', desc = 'Next [D]iagnostic' },
      { '[x', desc = 'Avante: Prev Diff' },
      { ']x', desc = 'Avante: Next Diff' },
      { '[[', desc = 'Avante: Prev Chunk' },
      { ']]', desc = 'Avante: Next Chunk' },

      -- Ctrl combos (normal mode)
      { '<C-e>', desc = 'Harpoon: Quick Menu' },
      { '<C-m>', desc = 'Harpoon: Select [1]' },
      { '<C-,>', desc = 'Harpoon: Select [2]' },
      { '<C-.>', desc = 'Harpoon: Select [3]' },
      { '<C-/>', desc = 'Harpoon: Select [4]' },
      { '<C-d>', desc = 'Page Down (centered)' },
      { '<C-u>', desc = 'Page Up (centered)' },

      -- Alt combos
      { '<M-c>', desc = '[C]opy to system clipboard', mode = { 'n', 'v' } },
    }
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
