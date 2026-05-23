return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false,
    build = 'make',
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
      mode = 'agentic',
      acp_providers = {
        ['claude-code'] = {
          command = 'npx',
          args = { '-y', '-g', '@zed-industries/claude-code-acp' },
          env = {
            NODE_NO_WARNINGS = '1',
            ACP_PATH_TO_CLAUDE_CODE_EXECUTABLE = vim.fn.exepath('claude'),
            ACP_PERMISSION_MODE = 'default',
          },
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        minimize_diff = true,
        auto_add_current_file = true,
        enable_token_counting = true,
        auto_approve_tool_permissions = false,
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
  },
}
