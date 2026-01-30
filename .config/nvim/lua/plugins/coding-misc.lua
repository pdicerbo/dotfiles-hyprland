return {
    {
        "rmagatti/auto-session",
        config = function()
            local auto_session = require("auto-session")

            auto_session.setup({
                auto_restore = false,
                suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" }
            })

            local keymap = vim.keymap
            keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>",   { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
            keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>",      { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
        end,
    },

    {
        "cappyzawa/trim.nvim",
        config = function()
            require("trim").setup({
                ft_blocklist = {"markdown", "snacks-dashboard"},
                trim_on_write = true,
                trim_trailing = true,
                trim_last_line = true,
                trim_first_line = true,
                highlight = true,
                highlight_bg = '#ff0000', -- or 'red'
                highlight_ctermbg = 'red',
                notifications = true,
            })
            vim.keymap.set("n", "<C-k><C-x>", ":TrimToggle<CR>", { desc = "Toggle Trim on save" })
        end,
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "<leader>fj", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "<leader>fT", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },

    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },

    {
        -- breadcrumbs in winbar
        'Bekaboo/dropbar.nvim',

        config = function()
            local dropbar_api = require('dropbar.api')
            -- vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
            vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
            vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
        end
    },

    {
        -- highlight text matching the current selection in visual mode
        "wurli/visimatch.nvim",
        opts = {}
    },

}
