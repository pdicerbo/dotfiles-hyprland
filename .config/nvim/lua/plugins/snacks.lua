-- Terminal Mappings
local function term_nav(dir)
    return function(self)
        return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
            vim.cmd.wincmd(dir)
        end)
    end
end

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        indent = { enabled = true },
        explorer = { enabled = true },
        input = {
            enabled = true,
            icon = " ",
            icon_hl = "SnacksInputIcon",
            icon_pos = "left",
            prompt_pos = "title",
            win = { style = "input" },
            expand = true,
        },
        lazygit = {
            configure = true,
            config = {
                os = { editPreset = "nvim-remote", },
                gui = {
                    -- set to an empty string "" to disable icons
                    nerdFontsVersion = "3",
                },
            },
            win = {
                style = "lazygit",
            },
        },
        picker = {
            hidden = true,
            ignored = true,
            sources = {
                files = {
                    hidden = true,
                    ignored = true,
                },
                explorer = {
                    git_status_open = true,
                    actions = {
                        copy_file_path = {
                            action = function(_, item)
                                if not item then
                                    return
                                end

                                local vals = {
                                    ["BASENAME"] = vim.fn.fnamemodify(item.file, ":t:r"),
                                    ["EXTENSION"] = vim.fn.fnamemodify(item.file, ":t:e"),
                                    ["FILENAME"] = vim.fn.fnamemodify(item.file, ":t"),
                                    ["PATH"] = item.file,
                                    ["PATH (CWD)"] = vim.fn.fnamemodify(item.file, ":."),
                                    ["PATH (HOME)"] = vim.fn.fnamemodify(item.file, ":~"),
                                    ["URI"] = vim.uri_from_fname(item.file),
                                }

                                local options = vim.tbl_filter(function(val)
                                    return vals[val] ~= ""
                                end, vim.tbl_keys(vals))
                                if vim.tbl_isempty(options) then
                                    vim.notify("No values to copy", vim.log.levels.WARN)
                                    return
                                end
                                table.sort(options)
                                vim.ui.select(options, {
                                    prompt = "Choose to copy to clipboard:",
                                    format_item = function(list_item)
                                        return ("%s: %s"):format(list_item, vals[list_item])
                                    end,
                                }, function(choice)
                                        local result = vals[choice]
                                        if result then
                                            vim.fn.setreg("+", result)
                                            Snacks.notify.info("Yanked `" .. result .. "`")
                                        end
                                    end)
                            end,
                        },
                        search_in_directory = {
                            action = function(_, item)
                                if not item then
                                    return
                                end
                                local dir = vim.fn.fnamemodify(item.file, ":p:h")
                                Snacks.picker.grep({
                                    cwd = dir,
                                    cmd = "rg",
                                    args = {
                                        "-g",
                                        "!.git",
                                        "-g",
                                        "!node_modules",
                                        "-g",
                                        "!dist",
                                        "-g",
                                        "!build",
                                        "-g",
                                        "!coverage",
                                        "-g",
                                        "!.DS_Store",
                                        "-g",
                                        "!.docusaurus",
                                        "-g",
                                        "!.dart_tool",
                                    },
                                    show_empty = true,
                                    hidden = true,
                                    ignored = true,
                                    follow = false,
                                    supports_live = true,
                                })
                            end,
                        },
                        diff = {
                            action = function(picker)
                                picker:close()
                                local sel = picker:selected()
                                if #sel > 0 and sel then
                                    Snacks.notify.info(sel[1].file)
                                    vim.cmd("tabnew " .. sel[1].file)
                                    vim.cmd("vert diffs " .. sel[2].file)
                                    Snacks.notify.info("Diffing " .. sel[1].file .. " against " .. sel[2].file)
                                    return
                                end

                                Snacks.notify.info("Select two entries for the diff")
                            end,
                        },
                    },
                    win = {
                        list = {
                            keys = {
                                ["y"] = "copy_file_path",
                                ["s"] = "search_in_directory",
                                ["D"] = "diff",
                            },
                        },
                    },

                },
                git_files = {
                    untracked = true,
                    submodules = true,
                },
            },
        },
        notifier = {
            enabled = true,
            timeout = 6000,
        },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scratch = {
            enabled = true,
            win = {
                width = 0.7,
                height = 0.7,
                border = "rounded",
                title = "Scratch Buffer",
            },
        },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        terminal = {
            win = {
                keys = {
                    nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
                    nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
                    nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
                    nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
                },
            },
        },

        words = { enabled = true },
    },
    keys = {
        -- Top Pickers & Explorer
        { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
        { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
        { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
        { "<C-p>",     function() require("command-palette").show_commands() end, desc = "Command Palette", },
        -- find
        -- { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>Gg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
        { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
        -- git
        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
        { "<leader>Gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
        { "<leader>GL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
        { "<leader>Gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
        { "<leader>GS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
        { "<leader>Gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
        { "<leader>Gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
        -- Grep
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
        { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
        { "<leader>sz", function() Snacks.picker.grep_word({ layout = { preset = "ivy" }, glob = {vim.fn.expand("%:.")}}) end, desc = "Search in Current File", mode = { "n", "x" } },
        { "<leader>sZ", function() local word = vim.fn.expand("<cword>") Snacks.picker.lines({ layout = { preview = "preview", preset = "ivy", } }).input:set(word) end, desc = "Search in Current File", mode = { "n", "x" } },
        -- search
        { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
        { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
        { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
        { "<leader>sk", function() Snacks.picker.keymaps({ layout = "ivy" }) end, desc = "Keymaps" },
        { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
        { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
        { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
        -- { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
        { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
        { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
        { "<leader>uC", function() Snacks.picker.colorschemes({ layout = "ivy" }) end, desc = "Colorschemes" },
        -- LSP
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
        { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
        -- MISC
        { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
        { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
        { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        { "<leader>nf", function() Snacks.scratch({ win = { width = 0, height = 0, }}) end, desc = "Toggle Scratch Buffer (full window)" },
        { "<leader>nb", function() Snacks.scratch({ win = { position = 'right' }}) end, desc = "Toggle Scratch Buffer on the right" },
        { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
        { "<leader>GB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
        { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit log" },
        { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
        { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
        { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
        { "<leader>tt", function()
            local terms = Snacks.terminal.list()
            if terms and #terms > 0 then
                for _, term in ipairs(terms) do
                    term:toggle()
                end
            else
                Snacks.terminal()
            end
        end, desc = "Toggle All Terminals"
        },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
        { "<leader>yu", function()
            vim.fn.setreg("+", "#" .. vim.uri_from_fname(vim.fn.expand("%:p")))
            Snacks.notify.info("Copied URI: #" .. vim.uri_from_fname(vim.fn.expand("%:p")))
        end, desc = "Copy buffer URI to clipboard (e.g. for CopilotChat)" },
        { "<leader>yb", function()
            local buffers = {}
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.bo[buf].buflisted then
                    local name = vim.api.nvim_buf_get_name(buf)
                    if name ~= "" then
                        table.insert(buffers, { buf = buf, name = name })
                    end
                end
            end
            if #buffers == 0 then
                Snacks.notify.warn("No buffers with files")
                return
            end
            Snacks.picker({
                title = "Select buffers to copy URIs (Tab to select, Enter to confirm)",
                items = vim.tbl_map(function(b)
                    return {
                        text = vim.fn.fnamemodify(b.name, ":."),
                        file = b.name,
                        buf = b.buf,
                    }
                end, buffers),
                confirm = function(picker)
                    local sel = picker:selected()
                    local uris = {}
                    if #sel > 0 then
                        for _, item in ipairs(sel) do
                            table.insert(uris, "#" .. vim.uri_from_fname(item.file))
                        end
                    else
                        local current = picker:current()
                        if current then
                            table.insert(uris, "#" .. vim.uri_from_fname(current.file))
                        end
                    end
                    picker:close()
                    if #uris > 0 then
                        local result = table.concat(uris, "\n")
                        vim.fn.setreg("+", result)
                        Snacks.notify.info("Copied " .. #uris .. " URI(s):\n" .. result)
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
        end, desc = "Copy multiple buffer URIs to clipboard (for CopilotChat)" },
    },
}
