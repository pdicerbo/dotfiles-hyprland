return {

    {
        "coffebar/neovim-project",
        opts = {
            projects = { -- define project roots
                "~/0LF/*",
                "~/0LF",
                "~/EXP0/*",
                "~/EXP0",
                "~/code_utils",
                "~/DockerEnvs",
                "~/MyDotFiles",
                "~/POCs/*",
                "/workspaces/*",
                "/workspaces",
                "~/.config/*",
            },
            picker = {
                type = "snacks",
            }
        },
        init = function()
            -- enable saving the state of plugins in the session
            vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
        end,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "Shatur/neovim-session-manager" },
        },
        lazy = false,
        priority = 100,
        keys = {
            { "<M-f>", "<cmd>NeovimProjectDiscover history<CR>", desc = "Discover Projects" },
            { "<M-d>", "<cmd>NeovimProjectHistory<CR>", desc = "Projects History" },
        }
    },

}
