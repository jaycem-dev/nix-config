-- OPTIONS
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

-- AUTOCMD
-- highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- PLUGINS
-- plugins installed on default.nix
require("colorizer").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("mini.diff").setup()
require("mini.git").setup()
require("mini.statusline").setup()
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("which-key").setup({ preset = "helix", delay = 500 })

require("blink.cmp").setup({
    completion = { documentation = { auto_show = true } },
    signature = { enabled = true },
})

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit UI" })

require("oil").setup()
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", "<cmd>edit .<cr>", { desc = "Open file explorer" })

-- flash
require("flash").setup({ rainbow = { enabled = true } })
vim.keymap.set({ "n", "x", "o" }, "gw", function()
    require("flash").jump()
end, { desc = "Go to word" })
vim.keymap.set({ "n", "x", "o" }, "gW", function()
    require("flash").treesitter()
end, { desc = "Go to word (treesitter)" })
