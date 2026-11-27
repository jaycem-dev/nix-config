-- plugins managed via programs.neovim.plugins in default.nix
local fzf = require("fzf-lua")
local map = vim.keymap.set

fzf.setup({
    ui_select = {},
    -- faster ui draw
    defaults = { git_icons = false, file_icons = false },
    winopts = { border = vim.o.winborder, preview = { border = vim.o.winborder } },
})

-- git
map("n", "<leader>gb", fzf.git_branches, { desc = "Git branches" })
map("n", "<leader>gc", fzf.git_commits, { desc = "Git commits" })

-- files & buffers
map("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
map("n", "<leader>ff", fzf.files, { desc = "Files" })

-- search
map("n", "<leader>/", fzf.live_grep, { desc = "Live grep" })
map("n", "<leader>fw", fzf.grep_cword, { desc = "Grep word under cursor" })
map("n", "<leader><space>", fzf.resume, { desc = "Resume last picker" })

-- misc
map("n", "<leader>fo", fzf.oldfiles, { desc = "Old files" })

-- LSP
map("n", "<leader>fa", fzf.lsp_code_actions, { desc = "Code actions" })
map("n", "<leader>fr", fzf.lsp_references, { desc = "LSP references" })
map("n", "<leader>fi", fzf.lsp_implementations, { desc = "LSP implementations" })
map("n", "<leader>ft", fzf.lsp_typedefs, { desc = "LSP Type definition" })
map("n", "<leader>fD", fzf.diagnostics_workspace, { desc = "LSP workspace diagnostics" })
map("n", "<leader>fd", fzf.diagnostics_document, { desc = "LSP diagnostics" })
map("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "LSP symbols" })
map("n", "<leader>fS", fzf.lsp_workspace_symbols, { desc = "LSP workspace symbols" })

-- neovim
map("n", "<leader>fm", fzf.marks, { desc = "Marks" })
map("n", "<leader>fk", fzf.keymaps, { desc = "Keymaps" })
map("n", "<leader>fh", fzf.helptags, { desc = "Help" })
map("n", "<leader>s", fzf.spell_suggest, { desc = "Spell suggestions" })
