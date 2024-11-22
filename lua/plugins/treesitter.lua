return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = vim.fn.argc(-1) == 0,
	--opts_extend = { "ensure_installed" },
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = {
			-- Compiled
			"c",
			"asm",
			-- Vim related
			"vim",
			"vimdoc",
			-- Web
			"javascript",
			"html",
			"css",
			-- Script
			"ruby",
			"python",
			"lua",
			"bash",
			-- Others
			"comment",
		},
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
