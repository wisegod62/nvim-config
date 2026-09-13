-- =========================================
-- DIAGNOSTICS
-- =========================================

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,

	float = {
		border = "rounded",
	},
})


-- =========================================
-- LSP ATTACH
-- =========================================

local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", {
	clear = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,

	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		-- Use mini.completion for LSP completion
		if client and client:supports_method("textDocument/completion") then
			vim.bo[bufnr].omnifunc =
				"v:lua.MiniCompletion.complete_func_lsp"
		end

		local opts = {
			buffer = bufnr,
			silent = true,
		}

		-- Navigation
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
			buffer = bufnr,
			desc = "Go to declaration",
		})

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
			buffer = bufnr,
			desc = "Go to definition",
		})

		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {
			buffer = bufnr,
			desc = "Go to implementation",
		})

		vim.keymap.set("n", "gr", vim.lsp.buf.references, {
			buffer = bufnr,
			desc = "Find references",
		})

		-- Documentation
		vim.keymap.set("n", "K", vim.lsp.buf.hover, {
			buffer = bufnr,
			desc = "Hover documentation",
		})

		-- Refactoring
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
			buffer = bufnr,
			desc = "Rename symbol",
		})

		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
			buffer = bufnr,
			desc = "Code action",
		})
	end,
})


-- =========================================
-- PYTHON
-- =========================================

vim.lsp.config("pyright", {
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
		},
	},
})

vim.lsp.enable("pyright")


-- =========================================
-- C / C++
-- =========================================

vim.lsp.config("clangd", {
	filetypes = {
		"c",
		"cpp",
		"objc",
		"objcpp",
	},

	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=never",
	},
})

vim.lsp.enable("clangd")


-- =========================================
-- LUA
-- =========================================

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
			},

			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.enable("lua_ls")

