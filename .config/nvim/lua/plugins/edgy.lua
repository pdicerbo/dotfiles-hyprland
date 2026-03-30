return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
		vim.opt.laststatus = 3 -- show a single status line at the bottom
		vim.opt.splitkeep = "screen" -- prevents jumping when open/close sidebars
	end,
    keys = {
        {
            "<leader>ue",
            function()
                require("edgy").toggle()
            end,
            desc = "Edgy Toggle",
        },
        -- stylua: ignore
        { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
    },
    opts = {
        right = {
            {
                title = "Search & Replace",
                ft = "grug-far",
                size = { width = 0.3 },
            },

            {
                title = "AI Chat",
                ft = "copilot-chat",
                size = { width = 0.34 },
                wo = { winbar = false },
            },
        },
        bottom = {
            {
                title = "Terminal %{b:snacks_terminal.id}",
                ft = "snacks_terminal",
                size = { height = 0.5 },
                filter = function(_, win)
                    return vim.w[win].snacks_win
                        and vim.w[win].snacks_win.position == "bottom"
                        and vim.w[win].snacks_win.relative == "editor"
                        and not vim.w[win].trouble_preview
                end,
            },
        },
        animate = {
            cps = 300
        },

        wo = {
            winblend = 100,
            winhighlight = "NormalFloat:MyTransparentGroup",
        },

        keys = {
            -- increase width
            ["<c-Right>"] = function(win)
                win:resize("width", 2)
            end,
            -- decrease width
            ["<c-Left>"] = function(win)
                win:resize("width", -2)
            end,
            -- increase height
            ["<c-Up>"] = function(win)
                win:resize("height", 2)
            end,
            -- decrease height
            ["<c-Down>"] = function(win)
                win:resize("height", -2)
            end,
        },
    }
}
