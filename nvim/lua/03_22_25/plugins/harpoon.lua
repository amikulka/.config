return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon.setup {}
    -- harpoon.config.settings.save_on_toggle = true
    -- harpoon.config.settings.sync_on_ui_close = true

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = '[H]arpoon [A]dd current file' })
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    vim.keymap.set('n', '<C-m>', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<C-,>', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<C-.>', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<C-/>', function()
      harpoon:list():select(4)
    end)

    -- Note: C-n and C-p removed to avoid conflicts with avante.nvim suggestions
  end,
}
