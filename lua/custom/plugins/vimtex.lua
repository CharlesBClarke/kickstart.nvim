return {
  'lervag/vimtex',
  lazy = false, -- Avoid lazy loading for full functionality
  -- tag = "v2.15", -- Uncomment to pin to a specific release
  init = function()
    -- PDF viewer configuration
    vim.g.vimtex_view_method = 'zathura'

    -- Use latexmk as the default compiler
    vim.g.vimtex_compiler_method = 'latexmk'

    -- Disable quickfix auto-open on warnings or errors
    vim.g.vimtex_quickfix_open_on_warning = 0

    -- Optimize conceal settings for better readability
    vim.g.tex_conceal = 'abdmg'
    vim.opt.conceallevel = 1

    -- Disable features you don't need
    vim.g.vimtex_fold_enabled = 0 -- Disable folding
    vim.g.vimtex_indent_enabled = 1 -- Enable LaTeX-specific indentation
    vim.g.vimtex_syntax_enabled = 1 -- Enable syntax highlighting

    -- Define a local leader key for VimTeX
    vim.g.maplocalleader = ','

    -- Optional: Specify custom compilation options
    vim.g.vimtex_compiler_latexmk = {
      build_dir = 'build',
      options = {
        '-pdf',
        '-interaction=nonstopmode',
        '-synctex=1',
      },
    }
  end,
}
