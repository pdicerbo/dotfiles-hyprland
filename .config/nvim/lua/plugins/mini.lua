return {

    {
        -- Extend and create a/i textobjects
        'nvim-mini/mini.ai', version = '*',
        config = function()
            require('mini.ai').setup()
        end

    },

    {
        -- Move any selection in any direction
        'nvim-mini/mini.move', version = '*',
        config = function()
            require('mini.move').setup()
        end

    },

    {
        -- Autopairs
        "nvim-mini/mini.pairs",
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
            -- skip autopair when next character is one of these
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            -- skip autopair when the cursor is inside these treesitter nodes
            skip_ts = { "string" },
            -- skip autopair when next character is closing pair
            -- and there are more closing pairs than opening pairs
            skip_unbalanced = true,
            -- better deal with markdown code blocks
            markdown = true,
        },
        config = function(_, opts)
            require('mini.pairs').setup(opts)
        end,
    },

    {
        -- Surround actions
        'nvim-mini/mini.surround', version = '*',
        config = function()
            require('mini.surround').setup()
        end
    },

    {
        -- Split & join
        "nvim-mini/mini.splitjoin",
        config = function()
            local miniSplitJoin = require("mini.splitjoin")
            miniSplitJoin.setup({
                mappings = { toggle = "" }, -- Disable default mapping
            })
            vim.keymap.set({ "n", "x" }, "mj", function() miniSplitJoin.join() end, { desc = "Join arguments" })
            vim.keymap.set({ "n", "x" }, "mk", function() miniSplitJoin.split() end, { desc = "Split arguments" })
        end,
    },

    {
        -- automatic highlighting of word under cursor
        "nvim-mini/mini.cursorword",
        config = function()
            require("mini.cursorword").setup()
        end,
    },


}
