return {
	"mhartington/formatter.nvim",
	config = function()
		-- Utilities for creating configurations
		-- local util = require "formatter.util"

		-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
		require("formatter").setup({
			-- Enable or disable logging
			logging = true,
			-- Set the log level
			log_level = vim.log.levels.WARN,
			-- All formatter configurations are opt-in
			filetype = {
				ruby = {
					require("formatter.filetypes.ruby").rubocop(),
				},
				lua = {
					require("formatter.filetypes.lua").stylua(),
				},
				javascript = {
					require("formatter.filetypes.javascript").prettier(),
				},
				css = {
					require("formatter.filetypes.css").prettier(),
				},
				eruby = {
					require("formatter.filetypes.eruby").htmlbeautifier(),
				},
				html = {
					require("formatter.filetypes.html").prettier(),
				},
				json = {
					require("formatter.filetypes.json").prettier(),
				},

				-- any filetype
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
					-- Remove trailing whitespace without 'sed'
					-- require("formatter.filetypes.any").substitute_trailing_whitespace,
				},
			},
		})

		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd
		augroup("__formatter__", { clear = true })
		autocmd("BufWritePost", {
			group = "__formatter__",
			command = ":FormatWrite",
		})
	end,
}
