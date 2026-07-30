return {
    {
        -- NEW: Optimizes Lua LSP specifically for Neovim configs, plugins, and APIs
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Load luvit types when the runtime matches it
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
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
                "ruff",
                "lua_ls", -- NEW: Installs Lua Language Server
            },
        },
        config = true,
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = {
                "black",
                "clang-format",
                "stylua", -- OPTIONAL: Highly recommended Lua formatter
            },
        },
        config = function(_, opts)
            require("mason-tool-installer").setup(opts)
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("config.lsp")
        end,
    },

    {
        "hrsh7th/nvim-cmp",
    },

    {
        "hrsh7th/cmp-nvim-lsp",
    },
}

