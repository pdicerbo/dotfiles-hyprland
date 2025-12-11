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
        action = function()
            vim.cmd("UndotreeToggle")
        end,
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
        action = function()
            require("gitlab").choose_merge_request()
        end,
    },

    {
        name = "Gitlab Start Review",
        action = function()
            require("gitlab").review()
        end,
    },

    {
        name = "LSP: Hover Documentation",
        action = function()
            -- Delay needed to ensure the picker is fully closed before showing the hover float
            vim.defer_fn(function()
                vim.lsp.buf.hover()
            end, 10)
        end,
    },

    {
        name = "LSP: Hover Diagnostics",
        action = function()
            -- Delay needed to ensure the picker is fully closed before showing the diagnostic float
            vim.defer_fn(function()
                vim.diagnostic.open_float()
            end, 10)
        end,
    },

    {
        name = "LSP: Hover Signature Documentation",
        action = function()
            -- Delay needed to ensure the picker is fully closed before showing the signature float
            vim.defer_fn(function()
                vim.lsp.buf.signature_help()
            end, 10)
        end,
    },

    {
        name = "LSP: Go to Declaration",
        action = function()
            vim.lsp.buf.declaration()
        end,
    },

    {
        name = "LSP: Go to Definitions",
        action = function()
            vim.lsp.buf.definition()
        end,
    },

    {
        name = "LSP: Go to References",
        action = function()
            vim.lsp.buf.references()
        end,
    },

    {
        name = "LSP: Go to Implementation",
        action = function()
            vim.lsp.buf.implementation()
        end,
    },

    {
        name = "LSP: Go to Type Definition",
        action = function()
            vim.lsp.buf.type_definition()
        end,
    },

    {
        name = "Print Colorscheme",
        action = ":echo g:colors_name",
    },

    {
        name = "LSP: Open Log File",
        action = function()
            vim.cmd.edit(vim.lsp.get_log_path())
        end,
    },

    {
        name = "LSP: Show Attached Clients",
        action = function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then
                vim.notify("No LSP clients attached to this buffer", vim.log.levels.WARN)
            else
                local names = vim.tbl_map(function(c) return c.name end, clients)
                vim.notify("Attached LSP clients: " .. table.concat(names, ", "), vim.log.levels.INFO)
            end
        end,
    },

    {
        name = "Buffer: Reload from Disk",
        action = function()
            vim.cmd("edit!")
        end,
    },

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
