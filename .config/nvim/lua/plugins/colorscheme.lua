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
            require("catppuccin").load('mocha')
            vim.cmd("colorscheme catppuccin")
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
