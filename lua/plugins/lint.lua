return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			ruby = { "rubocop" },
			-- javascript = { "eslint" },
			-- html = { "eslint" },
			-- css = { "eslint" },
			-- json = { "eslint" },
			-- typescipt = { "eslint" },
			eruby = { "erb_lint" },
		}
		vim.api.nvim_create_autocmd({ "BufReadPost", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
