-- disable inline error/hint/warn messages
vim.diagnostic.config({ virtual_text = false })
-- Show line diagnostics
vim.keymap.set("n", "<C-A>", function()
	vim.diagnostic.open_float(nil, { focus = false })
end)
