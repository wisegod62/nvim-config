local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- System integration
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.termguicolors = true

-- UI / editing
opt.confirm = true
opt.cursorline = true
opt.scrolloff = 10
opt.list = true

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99

-- Leader 

vim.g.mapleader = " "
vim.g.maplocalleader = " "
