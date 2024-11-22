return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())

		require("mason").setup()
		local mason_lspconfig = require("mason-lspconfig")
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnipets = "Replace",
						},
					},
				},
			},
			rubocop = {},
			ruby_lsp = {},
			html = {},
			ts_ls = {},
			cssls = {},
		}

		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
			handlers = {
				function(server_name)
					local server_config = servers[server_name] or {}
					server_config.capabilities =
						vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})
					require("lspconfig")[server_name].setup(server_config)
				end,
			},
		})

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})
	end, -- end config
}
