return {
    "potamides/pantran.nvim",
    -- event = "VeryLazy",
    lazy = true,
    cmd = { "Pantran" },
    keys = {
        { "<leader>tw", "<cmd>Pantran<CR>", mode = { "n", "v" }, desc = "Show Translate Window" },
        { "<leader>tr", function() return require("pantran").motion_translate() .. "_" end, mode = "n", noremap = true, silent = true, expr = true, desc = "Translate current line" },
        { "<leader>tr", function() return require("pantran").motion_translate() end,        mode = "x", noremap = true, silent = true, expr = true, desc = "Translate visual selection" },
        -- operator: <leader>tm{motion}, e.g. <leader>tmiw (word), <leader>tmip (paragraph), <leader>tm_ (current line)
        { "<leader>tm", function() return require("pantran").motion_translate() end,        mode = "n", noremap = true, silent = true, expr = true, desc = "Translate motion" },
    },
    config = function()
        local pantran = require("pantran")
        pantran.setup({
            default_engine = "google",
            -- translate.googleapis.com now answers 429 (rate limited); with curl's
            -- default 3 retries each translation stalls ~8s before pantran falls
            -- back to clients5.google.com. Fail fast instead.
            curl = { retry = 0 },
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
