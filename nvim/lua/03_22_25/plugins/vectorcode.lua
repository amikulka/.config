return {
  {
    'Davidyz/VectorCode',
    version = '*',
    build = 'uv tool upgrade vectorcode', -- This helps keeping the CLI up-to-date
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      n_query = 3,        -- Optimal balance: relevance vs speed
      timeout_ms = 3000,  -- Faster than default 5000ms
      exclude_this = true, -- Avoid circular references
    },
  },
}
