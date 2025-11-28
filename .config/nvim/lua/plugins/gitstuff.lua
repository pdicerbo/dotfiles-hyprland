return {

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            numhl = true,
            preview_config = {
                border = 'rounded',
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
                end

                -- Navigation
                map("n", "]h", gs.next_hunk, "Next Hunk")
                map("n", "[h", gs.prev_hunk, "Prev Hunk")

                -- Actions
                map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
                map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")

                map("v", "<leader>gs", function() -- stage selected hunk
                    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Stage hunk")
                map("v", "<leader>gr", function() -- reset selected hunk
                    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Reset hunk")

                map("n", "<leader>gS", gs.stage_buffer, "Stage buffer") -- stage whole buffer
                map("n", "<leader>gR", gs.reset_buffer, "Reset buffer") -- unstage whole buffer
                map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
                map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
                map("n", "<leader>gi", gs.preview_hunk_inline, "Preview hunk inline")
                map("n", "<leader>gbl", function() gs.blame_line({ full = true }) end, "Blame line")
                map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle line blame")
                map("n", "<leader>gw", gs.toggle_word_diff, "Toggle intra-line word-diff in the buffer")
                map("n", "<leader>gd", gs.diffthis, "Diff this")
                map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff this ~")

                -- set inline highlights for previews
                vim.api.nvim_set_hl(0, "GitSignsAddInline", { bg = "#233524", fg = "#a9ff68" })
                vim.api.nvim_set_hl(0, "GitSignsChangeInline", { bg = "#2e3440", fg = "#e0af68" })
                vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { bg = "#3a2323", fg = "#ff6c6b" })
            end,
        },
    },

    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            {
                "<leader>dv",
                function()
                    if next(require("diffview.lib").views) == nil then
                        vim.cmd("DiffviewOpen")
                    else
                        vim.cmd("DiffviewClose")
                    end
                end,
                desc = "Toggle DiffView Window",
            },
            { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "Open Diff View file history" },
            { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close DiffView" },
        },
        config = function()
            local actions = require("diffview.actions")
            require("diffview").setup({
                enhanced_diff_hl = true,
                keymaps = {
                    file_panel = {
                        { "n",  "u",    actions.scroll_view(-0.25),                                     { desc = "Scroll the view up" } },
                        { "n",  "d",    actions.scroll_view(0.25),                                      { desc = "Scroll the view down" } },
                        { "n",  "gf",   function() actions.goto_file_edit() vim.cmd 'tabclose #' end,   { desc = "Go to file in the old tab" } },
                    },
                }
            })
        end,
    },

    {
        "harrisoncramer/gitlab.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
            "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
        },
        build = function () require("gitlab.server").build(true) end, -- Builds the Go binary
        config = function()
            require("gitlab").setup()
        end,
    },

}
