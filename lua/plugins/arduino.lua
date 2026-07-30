return {
    "stevearc/vim-arduino",
    lazy = false, -- Prevents filetype loading race conditions by keeping it available
    dependencies = {
        "neovim/nvim-lspconfig",
    },
    init = function()
        -- Map .ino extensions safely to the arduino context on startup
        vim.filetype.add({
            extension = {
                ino = "arduino",
                pde = "arduino",
            },
        })
    end,
    config = function()
        -- Quick keybindings using stevearc's global vim commands
        vim.keymap.set("n", "<leader>am", "<cmd>ArduinoChooseBoard<cr>", { desc = "Select Arduino Board" })
        vim.keymap.set("n", "<leader>ap", "<cmd>ArduinoChoosePort<cr>", { desc = "Select Serial Port" })
        vim.keymap.set("n", "<leader>au", "<cmd>ArduinoUpload<cr>", { desc = "Compile & Upload Sketch" })
        vim.keymap.set("n", "<leader>as", "<cmd>ArduinoSerial<cr>", { desc = "Open Serial Monitor" })

        -- Automated background compiler map tracking for clangd
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "arduino",
            callback = function()
                local current_dir = vim.fn.expand("%:p:h")
                if current_dir == "" then return end

                -- Pull the active target board (Fallback to Uno if unselected)
                local active_board = vim.g.arduino_board or "arduino:avr:uno"
                
                -- Isolate the temporary cache directory away from your code
                local cache_dir = "/tmp/arduino-lsp-cache"

                -- Build compilation database cleanly in /tmp, then extract ONLY compile_commands.json
                local cmd = string.format(
                    "mkdir -p %s && arduino-cli compile --only-compilation-database --build-path %s --fqbn %s %s && cp %s/compile_commands.json %s/",
                    cache_dir,
                    cache_dir,
                    active_board,
                    vim.fn.shellescape(current_dir),
                    cache_dir,
                    vim.fn.shellescape(current_dir)
                )

                -- Compile silently in a background frame thread
                vim.fn.jobstart(cmd, {
                    on_exit = function(_, exit_code)
                        if exit_code == 0 then
                            -- Refresh the active C++ LSP server structure
                            vim.cmd("LspRestart clangd")
                        end
                    end
                })
            end,
        })
    end,
}

