return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_quickfix_open_on_warning = 0
    vim.g.tex_conceal = 'abdmg'
    vim.opt.conceallevel = 1

    vim.g.vimtex_compiler_latexmk = {
      build_dir = 'build', -- <── everything goes here
      aux_dir = 'build', -- optional, keeps .aux .fls etc. with the PDF
      out_dir = 'build', -- optional, but nice if you split aux vs. out
      options = {
        '-pdf',
        '-interaction=nonstopmode',
        '-synctex=1',
        '-file-line-error',
        -- you **don’t** need “-outdir=build” here; VimTeX adds it
        -- but if you like to see it explicitly, you can:
        -- '-outdir=build',
      },
    }
  end,
}
