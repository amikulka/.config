return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets', 'Kaiser-Yang/blink-cmp-avante' },
    version = '1.*',
    opts = {
      keymap = {
        preset = 'super-tab',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<C-y>'] = { 'select_and_accept' },
        ['<C-k>'] = { 'show_documentation', 'hide_documentation' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        menu = {
          draw = {
            columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },
      sources = {
        default = { 'avante', 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 99,
          },
        },
      },
      signature = {
        enabled = true,
      },
    },
    opts_extend = { 'sources.default' },
  },
}
