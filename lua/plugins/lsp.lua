return {
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
                "black",
                "clang-format",
            },
        },
        config = true,
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
