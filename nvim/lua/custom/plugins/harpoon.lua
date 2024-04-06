return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon.setup {}
    harpoon.config.settings.save_on_toggle = true
    harpoon.config.settings.sync_on_ui_close = true

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add currnet file to harpoon' })
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

    -- Toggle previous & next buffers stored within Harpoon list
    -- uses alt p and alt n to avoid conflicts with other plugins
    vim.keymap.set('n', '<C-n>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-p>', function()
      harpoon:list():next()
    end)
  end,
}
