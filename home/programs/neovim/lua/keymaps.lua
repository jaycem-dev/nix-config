-- for plugin keymaps look into each plugin spec in /lua/plugins/*
local map = vim.keymap.set

-- builtin plugins
vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", require("undotree").open, { desc = "Toggle undotree" })

map("t", "<esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })
map("n", "<leader>l", "<cmd>buffer #<cr>", { desc = "Last buffer" })
map("n", "<C-c>", "<cmd>bwipeout<cr>", { desc = "Close current buffer" })
map("n", "<leader>vc", "<cmd>mksession<cr>", { desc = "Create session" })

-- clipboard and registers
map("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })

-- tab management
map("n", "<leader>tt", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader>tq", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader>tn", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader>tp", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

-- window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-left>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-down>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-up>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-right>", "<C-w>l", { desc = "Move to right window" })
-- move lines
map("v", "<C-down>", ":m '>+1<cr>gv=gv", { silent = true, desc = "Moves visual selection down" })
map("v", "<C-j>", ":m '>+1<cr>gv=gv", { silent = true, desc = "Moves visual selection down" })
map("v", "<C-up>", ":m '<-2<cr>gv=gv", { silent = true, desc = "Moves visual selection up" })
map("v", "<C-k>", ":m '<-2<cr>gv=gv", { silent = true, desc = "Moves visual selection up" })

map("n", "<leader>q", function()
    local is_open = vim.iter(vim.fn.getwininfo()):any(function(win)
        return win.quickfix == 1
    end)
    vim.cmd(is_open and "cclose" or "copen")
end, { desc = "Toggle Quickfix List" })

-- copy current file path
map("n", "<leader>c", function()
    local path = vim.fn.expand("%:.")
    vim.fn.setreg("+", path)
    vim.notify("Copied: " .. path)
end, { desc = "Copy file path" })
