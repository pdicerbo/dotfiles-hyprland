return {
    "eandrju/cellular-automaton.nvim",

    config = function()
        vim.keymap.set("n", "<leader>Fr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Start make_it_rain Animation" } )
        vim.keymap.set("n", "<leader>Fg", "<cmd>CellularAutomaton game_of_life<CR>", { desc = "Start game_of_life Animation" } )
        vim.keymap.set("n", "<leader>Fs", "<cmd>CellularAutomaton scramble<CR>", { desc = "Start scramble Animation" } )
    end
}
