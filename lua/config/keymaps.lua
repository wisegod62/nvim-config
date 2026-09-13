-- =========================================
-- LEADER
-- =========================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set


-- =========================================
-- WINDOW NAVIGATION
-- =========================================

-- Normal mode
keymap("n", "<A-h>", "<C-w>h", {
	desc = "Move to left window",
})

keymap("n", "<A-j>", "<C-w>j", {
	desc = "Move to lower window",
})

keymap("n", "<A-k>", "<C-w>k", {
	desc = "Move to upper window",
})

keymap("n", "<A-l>", "<C-w>l", {
	desc = "Move to right window",
})


-- Insert mode
-- <C-\><C-n> leaves insert/terminal mode before moving.
keymap("i", "<A-h>", "<C-\\><C-n><C-w>h", {
	desc = "Move to left window",
})

keymap("i", "<A-j>", "<C-\\><C-n><C-w>j", {
	desc = "Move to lower window",
})

keymap("i", "<A-k>", "<C-\\><C-n><C-w>k", {
	desc = "Move to upper window",
})

keymap("i", "<A-l>", "<C-\\><C-n><C-w>l", {
	desc = "Move to right window",
})


-- Terminal mode
keymap("t", "<A-h>", "<C-\\><C-n><C-w>h", {
	desc = "Move to left window",
})

keymap("t", "<A-j>", "<C-\\><C-n><C-w>j", {
	desc = "Move to lower window",
})

keymap("t", "<A-k>", "<C-\\><C-n><C-w>k", {
	desc = "Move to upper window",
})

keymap("t", "<A-l>", "<C-\\><C-n><C-w>l", {
	desc = "Move to right window",
})


-- =========================================
-- BUFFERS
-- =========================================

keymap("n", "<Tab>", "<cmd>bnext<CR>", {
	desc = "Next buffer",
})

keymap("n", "<S-Tab>", "<cmd>bprevious<CR>", {
	desc = "Previous buffer",
})


-- =========================================
-- TERMINAL
-- =========================================

keymap("t", "<Esc>", "<C-\\><C-n>", {
	desc = "Exit terminal mode",
})


-- =========================================
-- RUN PYTHON
-- =========================================

keymap("n", "<leader>rp", "<cmd>w<CR><cmd>!python3 %<CR>", {
	desc = "Run Python file",
})

