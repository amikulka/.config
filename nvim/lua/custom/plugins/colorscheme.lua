return {
  'catppuccin/nvim',
  name = 'catppuccin',
  opts = {
    integrations = {
      neotree = true,
      aerial = true,
      harpoon = true,
      mason = true,
      which_key = true,
    },
    dim_inactive = {
      enabled = true,
      percentage = 0.35,
    },
    color_overrides = {
      mocha = {
        rosewater = '#efc9c2',
        flamingo = '#ebb2b2',
        pink = '#f2a7de',
        mauve = '#b889f4',
        red = '#fc5153',
        maroon = '#ea838c',
        peach = '#f28500',
        yellow = '#fcf75e',
        green = '#03c03c',
        teal = '#3ab09e',
        sky = '#00bfff',
        sapphire = '#0067a5',
        blue = '#739df2',
        lavender = '#b6a8f6',
        text = '#c5d1f1',
        subtext1 = '#a6b0d8',
        subtext0 = '#959eb2',
        overlay2 = '#848c8d',
        overlay1 = '#717997',
        overlay0 = '#966371',
        surface2 = '#505469',
        surface1 = '#3e4255',
        surface0 = '#2c2f40',
        base = '#0e0f16',
        mantle = '#141620',
        crust = '#999999',
      },
    },
  },
  priority = 1000, -- make sure to load this before all the other start plugins
  init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    vim.cmd.colorscheme 'catppuccin'

    -- You can configure highlights by doing something like
    vim.cmd.hi 'Comment gui=none'
  end,
}
