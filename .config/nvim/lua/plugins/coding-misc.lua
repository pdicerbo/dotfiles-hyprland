return {
    {
        "rmagatti/auto-session",
        opts = {
            auto_restore = false,
            bypass_save_filetypes = { "snacks_dashboard" },
            cwd_change_handling = true,
            suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
            session_lens = {
                picker = "snacks",
            },
        },
        keys = {
            { "<leader>wr", "<cmd>AutoSession restore<CR>",          desc = "Restore session for cwd" },                                       -- restore last workspace session for current directory
            { "<leader>ws", "<cmd>AutoSession save<CR>",             desc = "Save session for auto session root dir" },                        -- save workspace session for current working directory
            { "<leader>wf", "<cmd>AutoSession search<CR>",           desc = "Search available sessions and restore" },                         -- search available sessions and restore
            { "<leader>wx", "<cmd>AutoSession purgeOrphaned<CR>",    desc = "removes all orphaned sessions with no working directory left" },  -- removes all orphaned sessions with no working directory left
        },
    },

    {
        "cappyzawa/trim.nvim",
        event = "VeryLazy",
        opts = {
                ft_blocklist = {"markdown", "snacks-dashboard"},
                trim_on_write = true,
                trim_trailing = true,
                trim_last_line = true,
                trim_first_line = true,
                highlight = true,
                highlight_bg = '#ff0000', -- or 'red'
                highlight_ctermbg = 'red',
                notifications = true,
        },
        keys = {
            { "<leader>tr", "<cmd>TrimToggle<CR>", desc = "Toggle Trim on save" },
        },
    },

    {
        -- breadcrumbs in winbar
        'Bekaboo/dropbar.nvim',
        event = "VeryLazy",
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
