vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.breakindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
-- TODO: use msg target when cmdheight is 0
require("vim._core.ui2").enable({ enable = true, msg = { target = "cmd" } })
-- vim.opt.cmdheight = 0 -- TODO: enable when there's a better way to show macro recording
