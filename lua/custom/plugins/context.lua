return {
  'nvim-treesitter/nvim-treesitter-context',
  config = function()
    require('treesitter-context').setup {
      enable = true,
      throttle = true,
      max_lines = 0, -- No limit
      patterns = {
        default = {
          'class',
          'function',
          'method',
        },
      },
    }
  end,
}
