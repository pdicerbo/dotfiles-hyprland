return {
    "nvim-pack/nvim-spectre",

    dependencies = { "nvim-lua/plenary.nvim" },

    keys = {
        { '<C-F>', function() require("spectre").toggle() end, desc = "Toggle Spectre" },
        { '<leader>sW', function() require("spectre").open_visual({select_word=true}) end, desc = "Search current word with Spectre", mode = 'n' },
        { '<leader>sW', function() require("spectre").open_visual() end, desc = "Search current word with Spectre", mode = 'v' },
        { '<leader>sp', function() require("spectre").open_file_search({select_word=true}) end, desc = "Search on current file with Spectre" },
    },
}
