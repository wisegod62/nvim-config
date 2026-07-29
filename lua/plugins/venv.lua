return {
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            name = { "venv", ".venv", "env", ".env" },
            auto_refresh = true,
        },
        keys = {
            { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python Venv" },
        },
    },
}
