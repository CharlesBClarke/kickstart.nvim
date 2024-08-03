-- Bootstrapping packer.nvim
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

ensure_packer()

-- Plugin management
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Packer itself
    use 'neovim/nvim-lspconfig'  -- LSP configurations
    use 'folke/tokyonight.nvim'  -- Tokyonight color scheme
    use 'morhetz/gruvbox'        -- Gruvbox color scheme
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    -- LaTeX support
    use 'lervag/vimtex'
    -- Autocompletion
    use 'hrsh7th/nvim-cmp'        -- Completion plugin
    use 'hrsh7th/cmp-buffer'      -- Source for text in buffer
    use 'hrsh7th/cmp-path'        -- Source for file system paths
    use 'hrsh7th/cmp-nvim-lsp'    -- Source for LSP
    -- Snippets
    use 'L3MON4D3/LuaSnip'        -- Snippet engine
    use 'saadparwaiz1/cmp_luasnip' -- For autocompletion
    use 'rafamadriz/friendly-snippets' -- Useful snippets
end)

-- General settings
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.o.background = "dark"         -- Set background to dark
vim.g.mapleader = " "             -- Set leader key to space

-- Set Gruvbox color scheme and enable transparency
vim.cmd("colorscheme gruvbox")
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("hi NonText guibg=NONE ctermbg=NONE")

-- Import capabilities from nvim-cmp.lua
local capabilities = require('nvim-cmp')

-- LSP Configuration
local on_attach = function(client, bufnr)
    -- Enable LSP-based formatting
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Keybindings for LSP
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async=true }) end, bufopts)

    -- Format on save
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end
        })
    end
end

-- Setup for clangd (C/C++)
require('lspconfig').clangd.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

-- Setup for haskell-language-server
require('lspconfig').hls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        haskell = {
            formattingProvider = "ormolu"
        }
    }
}

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- vimtex configuration
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'latexmk'
