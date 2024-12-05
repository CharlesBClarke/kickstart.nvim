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
    --debugger
    use 'mfussenegger/nvim-dap'
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
    --nvim-surround 
    use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
})   use 'rafamadriz/friendly-snippets' -- Useful snippets
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
--Kemaps terminal shit
vim.api.nvim_set_keymap('t', '<Esc><Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-t>', ':term<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-t>', [[<C-\><C-n>:q!<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-h>', [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-j>', [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-k>', [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-l>', [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-q>', [[<C-\><C-n>:q<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-\\>', ':split term://$SHELL<CR>', { noremap = true, silent = true })

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
    cmd = { "clangd", "--compile-commands-dir=" .. vim.fn.getcwd() .. "/build" },
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
-- Setup for Rust
local lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true
            },
            checkOnSave = {
                command = "clippy"
            }
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
require('vimtex')
-- Dap
require('dap-config')  -- Correct file name
-- boiler
function InsertBoilerplate(filetype)
    local templates = {
        leet = "/home/owner/Templates/leet.txt",
        cmake = "/home/owner/Templates/cmake.txt",
        -- Add more file types and templates as needed
    }

    local template = templates[filetype]
    if template then
        vim.cmd("read " .. template)
    else
        print("No template found for filetype: " .. filetype)
    end
end

vim.api.nvim_create_user_command('Boiler', function(opts)
    InsertBoilerplate(opts.args)
end, { nargs = 1 })

if os.getenv("NVIM_AUTO_COMMIT") then
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = function()
      vim.cmd("silent !git add . && git commit -m 'Auto commit triggered by Neovim'")
      print("Auto commit executed.")
    end,
  })
  print("Auto commit enabled for this directory.")
else
  print("Auto commit is disabled.")
end
