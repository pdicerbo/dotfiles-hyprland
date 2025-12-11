return {

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "diff",
                    "cpp",
                    "bash",
                    "cmake",
                    "cuda",
                    "dockerfile",
                    "git_config",
                    "gitignore",
                    "ini",
                    "json",
                    "jsonc",
                    "llvm",
                    "markdown",
                    "markdown_inline",
                    "proto",
                    "python",
                    "regex",
                    "rust",
                    "ssh_config",
                    "strace",
                    "tmux",
                    "xresources",
                    "yaml"
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = "<C-s>",
                        node_decremental = "<C-backspace>",
                    },
                },
                additional_vim_regex_highlighting = false,
            })
        end
    },

    {
        "nvim-treesitter/nvim-treesitter-context",

        config = function()
            require'treesitter-context'.setup{
                enable = false, -- Disabled by default
                multiline_threshold = 10, -- Maximum number of lines to show for a single context
            }
        end,

        keys = {
            { "<leader>bs", "<cmd>TSContext toggle<cr>", desc = "toggle treesitter context (aka sticky scroll breadcrumbs)" },
        },

    },

}
