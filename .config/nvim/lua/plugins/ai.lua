return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        -- optional = true,
        opts = {
            file_types = { "markdown", "copilot-chat", "codecompanion" },
        },
        ft = { "markdown", "copilot-chat", "codecompanion" },
    },

    {
        "github/copilot.vim",
        version = "v1.45.0",
        event = "VeryLazy",
        config = function()
            -- For copilot.vim
            -- enable copilot for specific filetypes
            vim.g.copilot_filetypes = {
                ["TelescopePrompt"] = false,
            }

            -- Set to true to assume that copilot is already mapped
            -- vim.g.copilot_assume_mapped = true
            -- -- Set workspace folders
            vim.g.copilot_workspace_folders = { vim.fn.getcwd() }

            -- -- Setup keymaps
            local keymap = vim.keymap.set
            local opts = { silent = true }
            --
            -- -- Set <C-y> to accept copilot suggestion
            -- keymap("i", "<C-y>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
            --
            -- -- Set <C-i> to accept line
            keymap("i", "<C-i>", "<Plug>(copilot-accept-line)", opts)
            keymap('i', '<C-l>', '<Plug>(copilot-accept-word)', opts)

            -- -- Set <C-j> to next suggestion, <C-k> to previous suggestion, <C-l> to suggest
            keymap("i", "<C-j>", "<Plug>(copilot-next)", opts)
            keymap("i", "<C-k>", "<Plug>(copilot-previous)", opts)
            keymap("i", "<C-p>", "<Plug>(copilot-suggest)", opts)
            --
            -- -- Set <C-d> to dismiss suggestion
            keymap("i", "<C-d>", "<Plug>(copilot-dismiss)", opts)
        end,
    },

    -- {
    --     "coder/claudecode.nvim",
    --     dependencies = { "folke/snacks.nvim" },
    --     config = true,
    --     lazy = false,
    --     opts = {
    --         terminal = {
    --             provider = "none",
    --             snacks_win_opts = {
    --                 wo = {
    --                     winblend = 100,
    --                     winhighlight = "NormalFloat:MyTransparentGroup",
    --                 }
    --             },
    --         },
    --         auto_start = true,
    --     },
    --     keys = {
    --         { "<leader>A", "",                                     desc = "AI/Claude Code", mode = { "n", "v" } },
    --         { "<leader>Am", "<cmd>ClaudeCodeSelectModel<cr>",      desc = "Select Claude Code model" },
    --         -- Diff management
    --         { "<leader>Aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    --         { "<leader>Ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    --     },
    -- },

    {
        "folke/sidekick.nvim",
        opts = {
            cli = {

                win = {
                    keys = {
                        buffers       = { "<c-b>", "buffers"   , mode = "nt", desc = "Sidekick: open buffer picker" },
                        files         = { "<c-f>", "files"     , mode = "nt", desc = "Sidekick: open file picker" },
                        hide_n        = { "q"    , "hide"      , mode = "n" , desc = "Sidekick: hide the terminal window" },
                        hide_ctrl_q   = { "<c-q>", "hide"      , mode = "n" , desc = "Sidekick: hide the terminal window" },
                        hide_ctrl_dot = { "<c-.>", "hide"      , mode = "nt", desc = "Sidekick: hide the terminal window" },
                        hide_ctrl_z   = { "<c-z>", "blur"      , mode = "nt", desc = "Sidekick: go back to the previous window without hiding the terminal" },
                        prompt        = { "<c-p>", "prompt"    , mode = "t" , desc = "Sidekick: insert prompt or context" },
                        stopinsert    = { "<c-q>", "stopinsert", mode = "t" , desc = "Sidekick: enter normal mode" },
                        -- Navigate windows in terminal mode. Only active when:
                        -- * layout is not "float"
                        -- * there is another window in the direction
                        -- With the default layout of "right", only `<c-h>` will be mapped
                        nav_left      = { "<M-H>", "nav_left"  , expr = true, desc = "Sidekick: navigate to the left window" },
                        nav_down      = { "<M-J>", "nav_down"  , expr = true, desc = "Sidekick: navigate to the below window" },
                        nav_up        = { "<M-K>", "nav_up"    , expr = true, desc = "Sidekick: navigate to the above window" },
                        nav_right     = { "<M-L>", "nav_right" , expr = true, desc = "Sidekick: navigate to the right window" },
                    },    wo = {
                        winblend = 100,
                        winhighlight = "NormalFloat:MyTransparentGroup",
                    },
                    split = {
                        width = 0.3, -- set to 0 for default split width
                    },
                },
                mux = {
                    enabled = false
                }
            },
        },
        keys = {
            {
                "<tab>",
                function()
                    -- if there is a next edit, jump to it, otherwise apply it if any
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<Tab>" -- fallback to normal tab
                    end
                end,
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
            {
                "<c-.>",
                function() require("sidekick.cli").focus() end,
                desc = "Sidekick Focus",
                mode = { "n", "t", "i", "x" },
            },
            {
                "<leader>aa",
                function() require("sidekick.cli").toggle() end,
                desc = "Sidekick Toggle CLI",
            },
            {
                "<leader>as",
                function() require("sidekick.cli").select() end,
                -- Or to select only installed tools:
                -- require("sidekick.cli").select({ filter = { installed = true } })
                desc = "Select CLI",
            },
            {
                "<leader>ad",
                function() require("sidekick.cli").close() end,
                desc = "Detach a CLI Session",
            },
            {
                "<leader>at",
                function() require("sidekick.cli").send({ msg = "{this}" }) end,
                mode = { "x", "n" },
                desc = "Send This",
            },
            {
                "<leader>af",
                function() require("sidekick.cli").send({ msg = "{file}" }) end,
                desc = "Send File",
            },
            {
                "<leader>av",
                function() require("sidekick.cli").send({ msg = "{selection}" }) end,
                mode = { "x" },
                desc = "Send Visual Selection",
            },
            {
                "<leader>ap",
                function() require("sidekick.cli").prompt() end,
                mode = { "n", "x" },
                desc = "Sidekick Select Prompt",
            },
            -- Example of a keybinding to open Claude directly
            {
                "<leader>ac",
                function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
                desc = "Sidekick Toggle Claude",
            },
        },
    }
}
