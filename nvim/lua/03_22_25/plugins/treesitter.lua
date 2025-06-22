-- ╭─────────────────────────────────────────────────────────╮
-- │ TREESITTER: Syntax highlighting and code analysis      │
-- │ LANGUAGES: JS/TS parsers handle JSX/TSX automatically  │
-- │ FEATURES: Highlighting, indentation, text objects       │
-- │ REACT SUPPORT: Fixed indentation, proper JSX parsing   │
-- │ PERFORMANCE: Auto-install parsers, optimized config    │
-- ╰─────────────────────────────────────────────────────────╯

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'go',
        'html',
        'javascript',  -- Handles JSX files
        'json',
        'lua',
        'make',
        'markdown',
        'python',
        'rust',
        'typescript', -- Handles TSX files
        'yaml',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system for indent rules.
        -- Modern treesitter handles TypeScript well, only keep problematic ones
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { 
        enable = true, 
        disable = { 'ruby' } -- Removed typescript - modern treesitter handles it well
      },
      text_objects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
      },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },
}
