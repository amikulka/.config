vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.have_nerd_font = true -- Set to true if you have a Nerd Font installed

vim.g.autoformat_enabled = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.opt.cmdheight = 0 -- Set command line at bottom to not show
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- Don't show the mode, since it's already in status line
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.smartcase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Displays which-key popup sooner
vim.opt.splitright = true -- Configure how new verticle splits should be opened
vim.opt.splitbelow = true -- Configure how new horizontal splits should be opened

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 20 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.fileencoding = 'utf-8'
vim.opt.hlsearch = true -- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.wrap = false -- No wrap text
vim.opt.expandtab = true -- Spaces for tabs
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for

-- Options for session manager library
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
