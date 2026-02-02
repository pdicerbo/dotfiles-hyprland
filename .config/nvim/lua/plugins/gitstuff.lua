-- Opens a branch picker and diffs current state against selected branch
local function diffview_branch()
    Snacks.picker.git_branches({
        confirm = function(picker)
            local item = picker:current()
            picker:close()
            if item then
                local branch = item.branch or item.name or item.text
                vim.cmd("DiffviewOpen " .. branch)
            end
        end,
    })
end

-- Opens a commit picker and diffs current state against selected commit
local function diffview_commit()
    Snacks.picker.git_log({
        confirm = function(picker)
            local item = picker:current()
            picker:close()
            if item and item.commit then
                vim.cmd("DiffviewOpen " .. item.commit)
            end
        end,
    })
end
-- Opens a commit picker for selecting 2 commits (via Tab) to diff a range
local function diffview_range()
    Snacks.picker.git_log({
        title = "Select 2 commits for range diff (Tab to select)",
        confirm = function(picker)
            local sel = picker:selected()
            picker:close()
            if #sel >= 2 then
                vim.cmd("DiffviewOpen " .. sel[2].commit .. ".." .. sel[1].commit)
            else
                Snacks.notify.warn("Select 2 commits with Tab")
            end
        end,
        win = {
            input = {
                keys = {
                    ["<Tab>"] = { "select_and_next", mode = { "n", "i" } },
                },
            },
        },
    })
end

-- Opens an input prompt to enter a commit hash and diff against it
local function diffview_input()
    vim.ui.input({ prompt = "Enter commit hash: " }, function(commit_hash)
        if commit_hash and commit_hash ~= "" then
            vim.cmd("DiffviewOpen " .. commit_hash)
        end
    end)
end

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
                desc = "Toggle Diffview",
            },
            { "<leader>dH", "<cmd>DiffviewFileHistory %<cr>", desc = "Open Diff View file history" },
            { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close DiffView" },
            { "<leader>db", diffview_branch, desc = "Diffview against branch" },
            { "<leader>dC", diffview_commit, desc = "Diffview against commit" },
            { "<leader>dh", diffview_input, desc = "Diffview against commit hash" },
            { "<leader>dr", diffview_range, desc = "Diffview commit range" },
            {
                "<leader>dm",
                function()
                    vim.ui.select(
                        { "Branch", "Commit", "Range (2 commits)", "Enter commit hash" },
                        { prompt = "Diffview against:" },
                        function(choice)
                            if not choice then return end
                            if choice == "Branch" then
                                diffview_branch()
                            elseif choice == "Commit" then
                                diffview_commit()
                            elseif choice == "Range (2 commits)" then
                                diffview_range()
                            elseif choice == "Enter commit hash" then
                                diffview_input()
                            end
                        end
                    )
                end,
                desc = "Diffview menu",
            },
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
