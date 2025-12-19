return {
    "brenoprata10/nvim-highlight-colors",
    config = function()
        local render_modes = { "background", "foreground", "virtual" }
        local current_mode = 1

        local function setup_colors()
            require("nvim-highlight-colors").setup {
                render = render_modes[current_mode],
            }
        end

        setup_colors()

        vim.keymap.set("n", "<leader>hc", function()
            require("nvim-highlight-colors").toggle()
        end, { desc = "Toggle highlight colors" })

        vim.keymap.set("n", "<leader>hr", function()
            current_mode = (current_mode % #render_modes) + 1
            setup_colors()
            vim.cmd("e")
            vim.notify("Highlight render: " .. render_modes[current_mode])
        end, { desc = "Cycle highlight render mode" })
    end,
}
