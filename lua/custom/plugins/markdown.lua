-- ~/.config/nvim/lua/custom/markdown.lua
return {
  {
    'dhruvasagar/vim-table-mode',
    ft = { 'markdown' },
    init = function()
      vim.g.table_mode_corner = '|' -- optional tweak
    end,
  },
}
