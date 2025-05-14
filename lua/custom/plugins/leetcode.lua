return {
	"kawre/leetcode.nvim",
	lazy = false, -- Ensure the plugin loads immediately
	dependencies = {
		"nvim-telescope/telescope.nvim", -- Optional, for better problem navigation
		"nvim-lua/plenary.nvim",
		"3rd/image.nvim",
		"MunifTanjim/nui.nvim", -- Required UI dependency
	},
	config = function()
		require("leetcode").setup({
			lang = "python3", -- Set default language (change to your preferred language)
			storage = { home = vim.fn.stdpath("data") .. "/leetcode" }, -- Set problem storage location
			console = { open_on_runcode = true }, -- Auto-open console when running code
			description = { position = "right" }, -- Position problem description
			injector = { --- Automatically injects Neovim commands into LeetCode's editor
				register = true, -- Registers :Leet command
			},
			image_support = false, -- Enables image rendering in descriptions (if `wezterm` or `kitty`)
			plugins = {
				non_standalone = true,
			},
		})

		-- Keybindings for LeetCode
		vim.api.nvim_set_keymap("n", "<leader>ll", ":Leet<CR>", { noremap = true, silent = true }) -- Open LeetCode
		vim.api.nvim_set_keymap("n", "<leader>lr", ":Leet run<CR>", { noremap = true, silent = true }) -- Run code
		vim.api.nvim_set_keymap("n", "<leader>ls", ":Leet submit<CR>", { noremap = true, silent = true }) -- Submit solution
		vim.api.nvim_set_keymap("n", "<leader>lp", ":Leet pick<CR>", { noremap = true, silent = true }) -- Pick a problem
	end,
}
