return {
  'm4xshen/hardtime.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    restricted_keys = {
      -- Your remapped directional keys
      ['n'] = { 'n', 'x' },
      ['e'] = { 'n', 'x' },
      ['i'] = { 'n', 'x' },
      ['m'] = { 'n', 'x' },
      ['h'] = {},
      ['j'] = {},
      ['k'] = {},
      ['l'] = {},
    },
  },
}
