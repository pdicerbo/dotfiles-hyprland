return {
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,       -- Load at startup
        priority = 1000,    -- High priority
        config = function()
            require("catppuccin").setup({
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = true,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                }
            })
            -- require("catppuccin").load('mocha')
            -- vim.cmd("colorscheme catppuccin")
        end
    },

    {
        "folke/tokyonight.nvim",
        lazy = true,
        -- priority = 1000,  -- High priority
        opts = {
            style = "storm",
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            -- vim.cmd("colorscheme tokyonight")
        end,
    },

    {
        "shaunsingh/nord.nvim",
        lazy = true,
    },

    {
        "Mofiqul/dracula.nvim",
        lazy = true,
    },

    {
        "marko-cerovac/material.nvim",
        lazy = true,
    },

    {
        "olimorris/onedarkpro.nvim",
        lazy = true,
        config = function()
            require("onedarkpro").setup({
                colors = {
                    cursorline = "#373b41"
                },
                options = {
                    cursorline = true
                }
            })
        end
    },

    {
        "adibhanna/forest-night.nvim",
        lazy = true,
    },


    {
        'D0nw0r/dark2026.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'dark2026'
            local function set_hl()
                vim.api.nvim_set_hl(0, "FlashLabel", { bg = "#000cb3", fg = "#ffffff", bold = true })
                vim.api.nvim_set_hl(0, "SnacksPickerListCursorLine", { bg = "#2a3f6f", bold = true })
                vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#7aa2f7" })
            end
            set_hl()
            vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
        end,
    },

    -- {
    --     "typicode/bg.nvim",
    --     lazy = false
    -- },

    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        keys = {
            { "<leader>bt", "<cmd>TransparentToggle<cr>", desc = "Toggle Transparent Background" },
        },
    }
}
