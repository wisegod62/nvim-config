return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,

		config = function()
			require("nvim-treesitter").setup()

			local languages = {
				"c",
				"cpp",
				"python",
				"lua",
			}

			require("nvim-treesitter").install(languages)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					if vim.tbl_contains(languages, vim.bo.filetype) then
						vim.treesitter.start()
					end
				end,
			})
		end,
	},
}

