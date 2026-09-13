vim.api.nvim_create_user_command("GitBlameLine", function()
	local line_number = vim.fn.line(".")
	local filename = vim.api.nvim_buf_get_name(0)

	if filename == "" then
		vim.notify("Buffer has no filename", vim.log.levels.WARN)
		return
	end

	local result = vim.system({
		"git",
		"blame",
		"-L",
		line_number .. ",+1",
		filename,
	}):wait()

	if result.code == 0 then
		print(result.stdout)
	else
		vim.notify(result.stderr, vim.log.levels.ERROR)
	end
end, {
	desc = "Show Git blame for current line",
})
