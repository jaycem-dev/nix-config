-- small plugins with small or no config
-- plugins managed via programs.neovim.plugins in default.nix
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
