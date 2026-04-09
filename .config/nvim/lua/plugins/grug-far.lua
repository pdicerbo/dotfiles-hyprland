return   {
    'MagicDuck/grug-far.nvim',
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    cmd = { "GrugFar", "GrugFarWithin" },
    config = function()
        -- optional setup call to override plugin options
        -- alternatively you can set options with vim.g.grug_far = { ... }
        require('grug-far').setup({
            -- options, see Configuration section below
            -- there are no required options atm
            engine = "ripgrep",
            headerMaxWidth = 80,
            transient = true,
        });
    end,
    keys = {
        {
            "<leader>gfs",
            function()
                local mode = vim.fn.mode()
                if mode == "v" or mode == "V" or mode == "\22" then
                    require('grug-far').with_visual_selection()
                else
                    require('grug-far').open()
                end
            end,
            mode = { "n", "x" },
            desc = "Search and Replace",
        },
        {
            "<leader>gfe",
            function()
                local grug = require("grug-far")
                local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                grug.open({
                    transient = true,
                    prefills = {
                        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                    },
                })
            end,
            mode = { "n", "x" },
            desc = "Search and Replace (pre-filter by the current file extension)",
        },
        { "<leader>R", mode = { "n" }, function() require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } }) end, desc = "Replace in current file" },
        { "<leader>R", mode = { "x" }, function() require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand("%") } }) end, desc = "Replace in current file" },
        { "<leader>gfr", mode = { "n", "v" }, function() require('grug-far').open({ visualSelectionUsage = 'operate-within-range' }) end, desc = "Search and Replace within range" },
    },
}
