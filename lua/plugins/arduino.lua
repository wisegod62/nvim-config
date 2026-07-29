return {
  "yuukiflow/arduino-nvim",
  ft = "arduino",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "neovim/nvim-lspconfig",
  },
  init = function()
    vim.filetype.add({
      extension = {
        ino = "arduino",
        pde = "arduino",
      },
    })
  end,
  config = function()
    -- Store the plugin instance to read its state variables
    local arduino = require("arduino")
    arduino.setup({})

    -- Quick Keybindings
    vim.keymap.set("n", "<leader>am", "<cmd>ArduinoSelectModel<cr>", { desc = "Select Arduino Board" })
    vim.keymap.set("n", "<leader>ap", "<cmd>ArduinoSelectPort<cr>", { desc = "Select Serial Port" })
    vim.keymap.set("n", "<leader>au", "<cmd>ArduinoUpload<cr>", { desc = "Compile & Upload Sketch" })
    vim.keymap.set("n", "<leader>as", "<cmd>ArduinoSerial<cr>", { desc = "Open Serial Monitor" })

    -- Automatically handle LSP maps for any board you activate
    vim.api.nvim_create_autocmd({ "FileType", "User" }, {
      -- Triggers on file load OR when you update state inside Arduino-Nvim
      pattern = { "arduino", "ArduinoStateChanged" },
      callback = function()
        -- Fall back to Uno if you haven't run <leader>am yet
        local current_fqbn = arduino.state.fqbn or "arduino:avr:uno"
        local current_dir = vim.fn.expand("%:p:h")
        
        -- Don't run if we aren't in a real workspace directory
        if current_dir == "" then return end

        -- Silently compile the JSON database in the background
        local cmd = string.format(
          "arduino-cli compile --only-compilation-database --fqbn %s %s",
          current_fqbn,
          vim.fn.shellescape(current_dir)
        )

        vim.fn.jobstart(cmd, {
          on_exit = function(_, exit_code)
            if exit_code == 0 then
              -- Reload clangd so it applies the new definitions
              vim.cmd("LspRestart clangd")
            end
          end
        })
      end,
    })
  end,
}

