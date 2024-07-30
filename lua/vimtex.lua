-- Basic vimtex configuration
vim.g.vimtex_view_method = 'zathura'  -- Use Zathura as the PDF viewer
vim.g.vimtex_compiler_method = 'latexmk'  -- Use latexmk for compilation
vim.g.vimtex_complete_enabled = 1  -- Enable completion
vim.g.vimtex_indent_enabled = 1  -- Enable indentation
vim.g.vimtex_syntax_enabled = 1  -- Enable syntax highlighting

-- Forward search configuration
vim.g.vimtex_compiler_latexmk = {
  build_dir = '',
  callback = 1,
  continuous = 1,
  executable = 'latexmk',
  options = {
    '-pdf',
    '-shell-escape',
    '-verbose',
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode',
  },
}

-- Additional vimtex settings
vim.g.vimtex_quickfix_mode = 1  -- Enable quickfix mode
vim.g.vimtex_fold_enabled = 0  -- Disable folding
vim.g.vimtex_format_enabled = 1  -- Enable formatting
vim.g.vimtex_format_border_begin = '\\begin{'  -- Format border begin
vim.g.vimtex_format_border_end = '\\end{'  -- Format border end
