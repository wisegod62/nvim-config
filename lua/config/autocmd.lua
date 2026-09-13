local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local custom_group = augroup("CustomAutocmds", { clear = true })

-- Highlight when yanking (copying) text.
autocmd("TextYankPost", {
	group = custom_group,
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

autocmd("BufReadPost", {
	group = custom_group,
	callback = function(args)
		local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) <= vim.fn.line("$")
		local not_commit = vim.b[args.buf].filetype ~= "gitcommit"

		if valid_line and not_commit then
			vim.cmd([[normal! g`"]])
		end
	end,
})
