return {
    "potamides/pantran.nvim",
    -- event = "VeryLazy",
    lazy = true,
    cmd = { "Pantran" },
    keys = {
        { "<leader>tw", "<cmd>Pantran<CR>", mode = { "n", "v" }, desc = "Show Translate Window" },
        { "<leader>tr",  function() return require("pantran").motion_translate() end,        mode = "n", noremap = true, silent = true, expr = true, desc = "Translate motion" },
        { "<leader>trr", function() return require("pantran").motion_translate() .. "_" end, mode = "n", noremap = true, silent = true, expr = true, desc = "Translate motion" },
        { "<leader>tr",  function() return require("pantran").motion_translate() end,        mode = "x", noremap = true, silent = true, expr = true, desc = "Translate visual selection" },
    },
    config = function()
        local pantran = require("pantran")
        pantran.setup({
            default_engine = "google",
            engines = {
                google = {
                    fallback = {
                        default_source = "en",
                        default_target = "it",
                    },
                },
            },
            ui = {
                width_percentage = 0.7,
                height_percentage = 0.4,
            },
            window = {
                title_border = { "⭐️ ", " ⭐️    " }, -- for google
                window_config = { border = "rounded" },
            },
        })

    end,
}
