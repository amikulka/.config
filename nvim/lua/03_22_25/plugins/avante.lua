return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
      'MeanderingProgrammer/render-markdown.nvim',
      {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
          },
        },
      },
    },
    opts = {
      provider = 'claude',
      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-sonnet-4-6',
          auth_type = 'max',
          timeout = 30000,
          extra_request_body = {
            temperature = 0,
            max_tokens = 8000,
          },
        },
      },
      input = {
        provider = 'dressing',
      },
      behaviour = {
        auto_suggestions = true,
        auto_suggestions_provider = 'claude',
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
      suggestion = {
        debounce = 1500,
        throttle = 1500,
      },
      mappings = {
        diff = {
          ours = 'co',
          theirs = 'ct',
          all_theirs = 'ca',
          both = 'cb',
          cursor = 'cc',
          next = ']x',
          prev = '[x',
        },
        suggestion = {
          accept = '<C-CR>',
          next = '<C-j>',
          prev = '<C-k>',
          dismiss = '<C-]>',
        },
        jump = {
          next = ']]',
          prev = '[[',
        },
        submit = {
          normal = '<CR>',
          insert = '<C-s>',
        },
        sidebar = {
          switch_windows = '<Tab>',
          reverse_switch_windows = '<S-Tab>',
        },
      },
      hints = { enabled = true },
      windows = {
        position = 'right',
        wrap = true,
        width = 30,
        sidebar_header = {
          align = 'center',
          rounded = true,
        },
      },
      highlights = {
        diff = {
          current = 'DiffText',
          incoming = 'DiffAdd',
        },
      },
    },
    build = 'make',
    config = function(_, opts)
      require('avante').setup(opts)
    end,
  },
}
