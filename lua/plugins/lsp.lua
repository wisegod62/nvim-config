return {
	{
		"folke/lazydev.nvim",
		ft = "lua",

		opts = {
			library = {
				{
					path = "${3rd}/luv/library",
					words = { "vim%.uv" },
				},
			},
		},
	},

	{
		"williamboman/mason.nvim",
		config = true,
	},

	{
		"williamboman/mason-lspconfig.nvim",

		dependencies = {
			"williamboman/mason.nvim",
		},

		opts = {
			ensure_installed = {
				"pyright",
				"clangd",
				"lua_ls",
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		dependencies = {
			"williamboman/mason.nvim",
		},

		opts = {
			ensure_installed = {
				"ruff",
				"clang-format",
				"stylua",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",

		config = function()
		require("config.lsp")
		end,
	},
}
