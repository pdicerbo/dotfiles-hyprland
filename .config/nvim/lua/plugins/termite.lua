return {
    -- Stacking float terminal manager for Neovim.
    "ruicsh/termite.nvim",
    event = "VeryLazy",
    opts = {
        height = 0.35,
        position = "bottom",
        winbar = false,
        keymaps = {
            prev = "<C-j>",
            next = "<C-k>",
        },
        highlights = {
            border_active   = { fg = "#ff9e64", bg = "NONE" },
        }
    }
}
