-- Set space as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ "t", "i" }, "<A-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set({ "t", "i" }, "<A-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set({ "t", "i" }, "<A-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set({ "t", "i" }, "<A-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set({ "n" }, "<A-h>", "<C-w>h")
vim.keymap.set({ "n" }, "<A-j>", "<C-w>j")
vim.keymap.set({ "n" }, "<A-k>", "<C-w>k")
vim.keymap.set({ "n" }, "<A-l>", "<C-w>l")

-- Buffer Management
keymap("n", "<tab>", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-tab>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Exit Terminal with <Esc>
keymap("t", "<Esc>", "<C-\\><C-n>")

-- Run Python files
keymap("n", "<leader>rp", ":w | !python3 %<CR>", { desc = "Run Python file" })

-- Make C files and run them
vim.keymap.set("n", "<leader>rc", function()
	vim.cmd("w")
	vim.cmd("vsplit term://make run")
	vim.cmd("startinsert")
end, { silent = true })
