return {
    {
        "nvim-mini/mini.nvim",
        version = false,

        opts = {
            pairs = {},

            completion = {
                delay = {
                    completion = 50,
                    info = 100,
                },
                window = {
                    info = {
                        height = 25,
                        width = 80,
                        border = "rounded",
                    },
                    signature = {
                        height = 25,
                        width = 80,
                        border = "rounded",
                    },
                },
            },

            statusline = {},
            comment = {},
            surround = {},
        },

        config = function(_, opts)
            for module, config in pairs(opts) do
                require("mini." .. module).setup(config)
            end
        end,
    },
}
