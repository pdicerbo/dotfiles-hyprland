return {
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
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
        lazy = false,  -- Load at startup
        priority = 1000,  -- High priority
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
        "typicode/bg.nvim",
        lazy = false
    },
}
