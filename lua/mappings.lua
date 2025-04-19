local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Lowercase -> command, Uppercase -> uppercase form
map('', 'n', 'gj', opts) -- Move cursor down by display line
map('', 'N', 'J', opts) -- Uppercase variant

map('', 'e', 'gk', opts) -- Move cursor up by display line
map('', 'E', 'K', opts) -- Uppercase variant

map('', 'i', 'l', opts) -- Move cursor right
map('', 'I', 'L', opts) -- Uppercase variant

map('', 'm', 'h', opts) -- Move cursor left
map('', 'M', 'H', opts) -- Uppercase variant

-- Additional Colemak-DH cursor movement mappings
map('', 'j', 'm', opts) -- Move cursor to the left
map('', 'J', 'M', opts) -- Uppercase variant

map('', 'k', 'n', opts) -- Move cursor down
map('', 'K', 'N', opts) -- Uppercase variant

map('', 't', 'i', opts) -- Move cursor right
map('', 'T', 'I', opts) -- Uppercase variant

map('', 'h', 'e', opts) -- Move cursor up
map('', 'H', 'E', opts) -- Uppercase variant

map('', 'l', 't', opts) -- Move cursor left
map('', 'L', 'T', opts) -- Uppercase variant

-- Move to window in the specified direction
map('', '<C-w>n', '<C-w>j', opts) -- Move to the window below
map('', '<C-w>e', '<C-w>k', opts) -- Move to the window above
map('', '<C-w>i', '<C-w>l', opts) -- Move to the window to the right
map('', '<C-w>m', '<C-w>h', opts) -- Move to the window to the left

-- Resizing windows
map('', '<C-w>J', '<C-w>-', opts) -- Decrease window height
map('', '<C-w>E', '<C-w>+', opts) -- Increase window height
map('', '<C-w>I', '<C-w>>', opts) -- Increase window width
map('', '<C-w>M', '<C-w><', opts) -- Decrease window width

-- Swap windows
map('', '<C-w><C-n>', '<C-w>K', opts) -- Move current window to the top
map('', '<C-w><C-e>', '<C-w>J', opts) -- Move current window to the bottom
map('', '<C-w><C-i>', '<C-w>L', opts) -- Move current window to the right
map('', '<C-w><C-m>', '<C-w>H', opts) -- Move current window to the left
