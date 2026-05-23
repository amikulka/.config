return {
  {
    'yetone/avante.nvim',
    enabled = true,
    event = 'VeryLazy',
    version = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
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
      provider = 'claude-code',
      auto_suggestions_provider = 'claude',
      mode = 'agentic',
      acp_providers = {
        ['claude-code'] = {
          command = 'npx',
          args = { '-y', '-g', '@zed-industries/claude-code-acp' },
          env = {
            NODE_NO_WARNINGS = '1',
            ANTHROPIC_API_KEY = os.getenv('ANTHROPIC_API_KEY'),
            ANTHROPIC_BASE_URL = os.getenv('ANTHROPIC_BASE_URL'),
            ACP_PATH_TO_CLAUDE_CODE_EXECUTABLE = vim.fn.exepath('claude'),
            ACP_PERMISSION_MODE = 'bypassPermissions',
          },
        },
      },
      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-sonnet-4-20250514',
          api_key_name = 'AVANTE_ANTHROPIC_API_KEY',
          timeout = 30000,
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 4096,
          },
        },
      },
      suggestion = {
        debounce = 1500,
        throttle = 1500,
      },
      behaviour = {
        auto_suggestions = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        minimize_diff = true,
        auto_add_current_file = true,
        enable_token_counting = true,
        auto_approve_tool_permissions = true,
        acp_follow_agent_locations = true,
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
        jump = {
          next = ']]',
          prev = '[[',
        },
        submit = {
          normal = '<CR>',
          insert = '<C-s>',
        },
        suggestion = {
          accept = '<M-l>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
        cancel = {
          normal = { '<C-c>', '<Esc>', 'q' },
          insert = { '<C-c>' },
        },
        sidebar = {
          apply_all = 'A',
          apply_cursor = 'a',
          retry_user_request = 'r',
          edit_user_request = 'e',
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
