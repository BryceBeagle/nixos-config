require('neo-tree').setup({
    close_if_last_window = true,
    popup_border_style = "rounded",
})

vim.keymap.set("n", "<leader><C-e>", ":Neotree buffers reveal float<CR>", {})
vim.keymap.set("n", "<leader><C-o>", ":Neotree filesystem toggle float<CR>", {})

