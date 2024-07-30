require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig' 
	use 'folke/tokyonight.nvim'
	use 'morhetz/gruvbox'
	use {
	'nvim-treesitter/nvim-treesitter',
	run = ':TSUpdate'
	}
	--latex
	use 'lervag/vimtex'
	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets
end)

-- LSP Configuration
local on_attach = function(client, bufnr)
    -- Enable LSP-based formatting
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    
    -- Keybindings for LSP
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)  -- Go to declaration
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)   -- Go to definition
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)         -- Hover to show documentation
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts) -- Go to implementation
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts) -- Show signature help
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts) -- Add workspace folder
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts) -- Remove workspace folder
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)  -- List workspace folders
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)  -- Go to type definition
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)  -- Rename symbol
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)  -- Show code actions
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)  -- Find references
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async=true }) end, bufopts)  -- Format code
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
require'lspconfig'.clangd.setup{
    on_attach = on_attach,
}

-- Setup for haskell-language-server
require'lspconfig'.hls.setup{
    on_attach = on_attach,
    settings = {
        haskell = {
            formattingProvider = "ormolu"
        }
    }
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
--vim.cmd[[colorscheme tokyonight]]
--vim.cmd("colorscheme vintage_ibm")
vim.opt.clipboard = "unnamedplus"
-- Set the color scheme
vim.o.background = "dark"  -- or "light" for light mode
vim.cmd("colorscheme gruvbox")
-- Enable transparency
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("hi NonText guibg=NONE ctermbg=NONE")
require('nvim-cmp')
--vimtex
require('vimtex')
vim.g.mapleader = " "  -- Set leader key to space
