return {
  "yuukiflow/Arduino-Nvim",
  ft = "arduino", -- Only loads when you open an Arduino file
  dependencies = {
    "nvim-telescope/telescope.nvim", -- Required for interactive dropdown menus
    "neovim/nvim-lspconfig",
  },
  init = function()
    -- Explicitly bind .ino files to the "arduino" filetype so lazy-loading triggers
    vim.filetype.add({
      extension = {
        ino = "arduino",
        pde = "arduino",
      },
    })
  end,
  config = function()
    -- FIX: The internal module name is 'arduino', NOT 'arduino-nvim'
    require("arduino").setup({
      -- You can leave this empty; it will look for 'arduino-cli' in your system PATH
    })

    -- Quick Keybindings
    vim.keymap.set("n", "<leader>am", "<cmd>ArduinoSelectModel<cr>", { desc = "Select Arduino Board" })
    vim.keymap.set("n", "<leader>ap", "<cmd>ArduinoSelectPort<cr>", { desc = "Select Serial Port" })
    vim.keymap.set("n", "<leader>au", "<cmd>ArduinoUpload<cr>", { desc = "Compile & Upload Sketch" })
    vim.keymap.set("n", "<leader>as", "<cmd>ArduinoSerial<cr>", { desc = "Open Serial Monitor" })
  end,
}

