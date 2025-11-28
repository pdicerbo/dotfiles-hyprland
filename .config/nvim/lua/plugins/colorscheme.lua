return {
    {
        "rebelot/kanagawa.nvim",
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
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
        end
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "storm",
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd("colorscheme tokyonight")
        end,
    },

    {
        "shaunsingh/nord.nvim",
        lazy = false,
        priority = 1000,
    },

    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
    },

    {
        "marko-cerovac/material.nvim",
        lazy = false,
        priority = 1000,
    },

    {
        "olimorris/onedarkpro.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedarkpro").setup({
                colors = {
                    cursorline = "#373b41"
                },
                options = {
                    cursorline = true
                }
            })
            -- vim.cmd("colorscheme onedark")
        end
    },

    {
        "adibhanna/forest-night.nvim",
        lazy = false,
        priority = 1000,
        -- config = function()
        --     vim.cmd("colorscheme forest-night")
        -- end
    },

    {
        "typicode/bg.nvim",
        lazy = false
    },
}
