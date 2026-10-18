return {
    -- discovering motions (Both vertical and horizontal) to navigate your current buffer
    "tris203/precognition.nvim",
    lazy = true,
    opts = {
        startVisible = false,
        showBlankVirtLine = false
    },
    vim.keymap.set("n", "<leader>hh", function() require("precognition").toggle() end, { desc = "Toggle Precognition" }),
}
