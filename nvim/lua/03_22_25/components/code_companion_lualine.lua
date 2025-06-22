-- ╭─────────────────────────────────────────────────────────╮
-- │ CODE COMPANION LUALINE: Status indicator component      │
-- │ FEATURES: Animated spinner during AI requests           │
-- │ PERFORMANCE: Optimized update frequency (200ms)         │
-- ╰─────────────────────────────────────────────────────────╯

local M = require('lualine.component'):extend()

M.processing = false
M.spinner_index = 1
M.last_update = 0

local spinner_symbols = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
local spinner_symbols_len = 10
local UPDATE_INTERVAL = 200 -- ms

-- Initializer
function M:init(options)
  M.super.init(self, options)

  local group = vim.api.nvim_create_augroup('CodeCompanionHooks', {})

  vim.api.nvim_create_autocmd({ 'User' }, {
    pattern = 'CodeCompanionRequest*',
    group = group,
    callback = function(request)
      if request.match == 'CodeCompanionRequestStarted' then
        self.processing = true
        self.last_update = vim.loop.now()
      elseif request.match == 'CodeCompanionRequestFinished' then
        self.processing = false
      end
    end,
  })
end

-- Optimized update function - only update every 200ms
function M:update_status()
  if not self.processing then
    return nil
  end
  
  local now = vim.loop.now()
  if now - self.last_update >= UPDATE_INTERVAL then
    self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
    self.last_update = now
  end
  
  return spinner_symbols[self.spinner_index]
end

return M
