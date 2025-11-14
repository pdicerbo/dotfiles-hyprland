local M = {}

M.commands = {
    {
        name = "Change File Type",
        action = function()
            local filetypes = {}
            for _, ft in ipairs(vim.fn.getcompletion("", "filetype")) do
                table.insert(filetypes, { text = ft, name = ft })
            end

            Snacks.picker({
                title = "File Types",
                layout = "select",
                items = filetypes,
                format = function(item)
                    local icon, icon_hl = require("snacks.util").icon(item.text, "filetype")
                    return {
                        { icon .. " ", icon_hl },
                        { item.text },
                    }
                end,
                confirm = function(picker, item)
                    picker:close()
                    vim.cmd.set("ft=" .. item.text)
                end,
            })
        end,
    },

    {
        name = "Copilot: Prompt actions",
        action = "<leader>cp",
    },

    {
        name = "Copilot: Action - Commit",
        action = ":CopilotChatCommit",
    },

    {
        name = "Copilot: Action - Explain",
        action = ":CopilotChatExplain",
    },

    {
        name = "Copilot: Action - Fix",
        action = ":CopilotChatFix",
    },

    {
        name = "Copilot: Action - Optimize",
        action = ":CopilotChatOptimize",
    },

    {
        name = "Copilot: Action - Review",
        action = ":CopilotChatReview",
    },

    {
        name = "Undo tree",
        action = "<leader>u",
    },

    {
        name = "Dim: Toggle",
        action = function()
            local snacks_dim = require("snacks").dim
            if snacks_dim.enabled then
                snacks_dim.disable()
            else
                snacks_dim.enable()
            end
        end,
    },

    {
        name = "Open Cppman",
        action = "<leader>cpp",
    },

    {
        name = "Find: Buffers",
        action = "<leader>fb",
    },

    {
        name = "Find: Diagnostics (Buffer)",
        action = "<leader>fd",
    },

    {
        name = "Find: Diagnostics (Workspace)",
        action = "<leader>fD",
    },

    {
        name = "Find: Files",
        action = "<leader>ff",
    },

    {
        name = "Fun Rain (Fr)",
        action = "<leader>Fr",
    },

    {
        name = "Fun Game of Life (Fg)",
        action = "<leader>Fg",
    },

    {
        name = "Fun scramble (Fs)",
        action = "<leader>Fs",
    },

    {
        name = "Cmake: Generate",
        action = "<leader>cg",
    },

    {
        name = "Cmake: Reconfigure",
        action = "<leader>cG",
    },

    {
        name = "Cmake: Build",
        action = "<leader>cb",
    },

    {
        name = "Cmake: Rebuild",
        action = "<leader>cB",
    },

    {
        name = "Cmake: Clean",
        action = "<leader>cx",
    },

    {
        name = "Cmake: Install",
        action = "<leader>cI",
    },

    {
        name = "Cmake: Stop",
        action = "<leader>cQ",
    },

    {
        name = "Find: Undo",
        action = "<leader>fu",
    },

    {
        name = "Git: Browse",
        action = function()
            Snacks.gitbrowse()
        end,
    },

    {
        name = "Git: Diff",
        action = "<leader>gdo",
    },

    {
        name = "Floaterm: Toggle",
        action = "<leader>tt",
    },

    {
        name = "Gitlab choose Merge Request",
        action = "glc",
    },

    {
        name = "Gitlab Start Review",
        action = "glS",
    },

    -- {
    --   name = "LSP: Diagnostics (Location List)",
    --   action = "<leader>lL",
    -- },

    -- {
    --   name = "LSP: Lint",
    --   action = "<leader>ll",
    -- },

    {
        name = "LSP: Hover Documentation",
        action = "K",
    },

    {
        name = "LSP: Hover Diagnostics",
        action = "J",
    },

    {
        name = "LSP: Hover Signature Documentation",
        action = function()
            vim.lsp.buf.signature_help()
        end,
    },

    {
        name = "LSP: Go to Declaration",
        action = "gD",
    },

    {
        name = "LSP: Go to Definitions",
        action = "gd",
    },

    {
        name = "LSP: Go to References",
        action = "gr",
    },

    {
        name = "LSP: Go to Implementation",
        action = "gI",
    },

    {
        name = "LSP: Go to Type Definition",
        action = "gy",
    },

    {
        name = "Marks: Find",
        action = "<leader>fm",
    },

    {
        name = "Marks: New",
        action = ":NewMark",
    },

    {
        name = "Search: Buffers",
        action = "<leader>f/",
    },

    {
        name = "Print Colorscheme",
        action = ":echo g:colors_name",
    },

    -- {
    --   name = "Tab: New",
    --   action = ":tabnew",
    -- },

    -- {
    --   name = "Tab: New Split",
    --   action = ":tab split",
    -- },

    -- {
    --   name = "Tab: Next",
    --   action = ":tabnext",
    -- },

    -- {
    --   name = "Tab: Previous",
    --   action = ":tabprevious",
    -- },

    -- {
    --   name = "Todo Comments: Quickfix List",
    --   action = ":TodoQuickFix",
    -- },

    -- {
    --   name = "Todo Comments: Location List",
    --   action = ":TodoLocList",
    -- },

}

function M.show_commands()
    local items = {}

    for idx, command in ipairs(M.commands) do
        local item = {
            idx = idx,
            name = command.name,
            text = command.name,
            action = command.action,
        }
        table.insert(items, item)
    end

    Snacks.picker({
        title = "Command Palette",
        layout = "select",
        items = items,
        format = function(item, _)
            return {
                { item.text, item.text_hl },

            }
        end,
        confirm = function(picker, item)
            if type(item.action) == "string" then
                if item.action:find("^:") then
                    picker:close()
                    return picker:norm(function()
                        picker:close()
                        vim.cmd(item.action:sub(2))
                    end)
                else
                    return picker:norm(function()
                        picker:close()
                        local keys = vim.api.nvim_replace_termcodes(item.action, true, true, true)
                        vim.api.nvim_input(keys)
                    end)
                end
            end

            return picker:norm(function()
                picker:close()
                item.action()
            end)
        end,
    })
end

return M
