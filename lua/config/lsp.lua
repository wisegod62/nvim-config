-- Standardize diagnostic visual treatment (warnings, errors, hints)
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = { border = "rounded" },
})

-- Request available language capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- =========================================
-- AUTOMATED LSP WORKSPACE ATTACHMENT EVENTS
-- =========================================

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- Force mini.completion to fetch structural intel instead of flat text words
        if client and client.supports_method("textDocument/completion") then
            vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.complete_func_lsp"
        end

        -- Core Code Navigation Keymaps (Activated only inside active code files)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    end,
})

-- ==============================================
-- LANGUAGE SERVER CONFIGURATION (Neovim 0.11+)
-- ==============================================

-- Python Setup
vim.lsp.config("pyright", {
    capabilities = capabilities,
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

-- C++ / Arduino Setup
local clangd_caps = vim.deepcopy(capabilities)
clangd_caps.offsetEncoding = { "utf-16" }

vim.lsp.config("clangd", {
    capabilities = clangd_caps,
    filetypes = { "c", "cpp", "objc", "objcpp", "arduino" },
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=never",
    },
})
vim.lsp.enable("clangd")

-- NEW: Lua Setup
vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false, -- Stops annoying prompts about external environments
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
vim.lsp.enable("lua_ls")
