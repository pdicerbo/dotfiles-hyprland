return {
    {
        -- Renders Markdown in-buffer (headings, code blocks, tables, etc.) without
        -- leaving Neovim. Scoped to specific filetypes so it doesn't activate elsewhere.
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            -- "copilot-chat" and "codecompanion" are the buffer filetypes used by those
            -- AI chat plugins, so their responses get the same rich formatting as .md files.
            file_types = { "markdown", "copilot-chat", "codecompanion" },
        },
        -- Lazy-load only when one of these filetypes is opened.
        ft = { "markdown", "copilot-chat", "codecompanion" },
    },

    {
        "github/copilot.vim",
        version = "v1.45.0",
        event = "VeryLazy",
        config = function()
            -- For copilot.vim
            -- enable copilot for specific filetypes
            vim.g.copilot_filetypes = {
                ["TelescopePrompt"] = false,
            }

            -- Set to true to assume that copilot is already mapped
            -- vim.g.copilot_assume_mapped = true
            -- -- Set workspace folders
            vim.g.copilot_workspace_folders = { vim.fn.getcwd() }

            -- -- Setup keymaps
            local keymap = vim.keymap.set
            local opts = { silent = true }
            --
            -- -- Set <C-y> to accept copilot suggestion
            -- keymap("i", "<C-y>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
            --
            -- -- Set <C-i> to accept line
            keymap("i", "<C-i>", "<Plug>(copilot-accept-line)", opts)
            keymap('i', '<C-l>', '<Plug>(copilot-accept-word)', opts)

            -- -- Set <C-j> to next suggestion, <C-k> to previous suggestion, <C-l> to suggest
            keymap("i", "<C-j>", "<Plug>(copilot-next)", opts)
            keymap("i", "<C-k>", "<Plug>(copilot-previous)", opts)
            keymap("i", "<C-p>", "<Plug>(copilot-suggest)", opts)
            --
            -- -- Set <C-d> to dismiss suggestion
            keymap("i", "<C-d>", "<Plug>(copilot-dismiss)", opts)
        end,
    },

    {
        "coder/claudecode.nvim",
        lazy = false,
        config = function()
            -- Headless mode: only runs the WebSocket/MCP server for IDE awareness.
            -- sidekick.nvim handles the terminal UI.
            require("claudecode").setup({
                ---@diagnostic disable-next-line: missing-fields
                terminal = {
                    provider = "none",
                },
                diff_opts = {
                    layout = "vertical",
                    open_in_new_tab = true,
                    -- hide the sidekick terminal in the diff tab so it gets full width
                    hide_terminal_in_new_tab = true,
                },
            })

            -- server.start() is synchronous, so port is available immediately after setup().
            -- Propagate the IDE integration env vars into Neovim's own process so that
            -- any terminal opened later (e.g. by sidekick) inherits them and the claude
            -- CLI can connect back to this WebSocket server.
            local cc = require("claudecode")
            if cc.state and cc.state.port then
                vim.fn.setenv("CLAUDE_CODE_SSE_PORT", tostring(cc.state.port))
                vim.fn.setenv("ENABLE_IDE_INTEGRATION", "true")
                vim.fn.setenv("FORCE_CODE_TERMINAL", "true")
            end

            -- Close all orphaned Claude diff windows
            vim.keymap.set("n", "<leader>aD", function()
                local ok, diff = pcall(require, "claudecode.diff")
                if ok and diff._cleanup_all_active_diffs then
                    diff._cleanup_all_active_diffs("manual cleanup")
                end
                -- Also close any remaining windows with diff-related scratch buffers
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    if vim.api.nvim_win_is_valid(win) then
                        local buf = vim.api.nvim_win_get_buf(win)
                        local name = vim.api.nvim_buf_get_name(buf)
                        if name:match("%(proposed%)") or name:match("%(NEW FILE") or name:match("%(New%)") then
                            pcall(vim.api.nvim_win_close, win, true)
                            pcall(vim.api.nvim_buf_delete, buf, { force = true })
                        end
                    end
                end
            end, { desc = "Close all Claude diffs" })

            -- Add convenient terminal exit keybinding
            vim.api.nvim_create_autocmd("TermOpen", {
                pattern = "*",
                callback = function()
                    local opts = { buffer = 0 }
                    -- Easy escape from terminal mode with Ctrl+q
                    vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", opts)
                    -- Or use Escape key twice for extra convenience
                    vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", opts)
                    -- Close terminal buffer easily with Ctrl+w q after escaping
                    vim.keymap.set("n", "<C-q>", ":q<CR>", opts)
                end,
            })
        end,
        keys = {
            { "<leader>a", "",                               desc = "AI/Claude Code", mode = { "n", "v" } },
            { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Diff Claude" },
            { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny Diff Claude" },
            { "<leader>aD", nil,                             desc = "Close all Claude diffs" },
        },
    },

    {
        -- sidekick.nvim is the terminal UI layer for AI CLIs (Claude, Gemini, etc.).
        -- It manages terminal sessions, context injection, and NES (Next Edit Suggestion).
        -- claudecode.nvim acts as the backend: it runs the WebSocket/MCP server that lets
        -- the claude CLI report back file edits and diffs to Neovim.
        "folke/sidekick.nvim",
        opts = {
            cli = {
                win = {
                    keys = {
                        buffers       = { "<c-b>", "buffers"   , mode = "nt", desc = "Sidekick: open buffer picker" },
                        files         = { "<c-f>", "files"     , mode = "nt", desc = "Sidekick: open file picker" },
                        hide_n        = { "q"    , "hide"      , mode = "n" , desc = "Sidekick: hide the terminal window" },
                        hide_ctrl_q   = { "<c-q>", "hide"      , mode = "n" , desc = "Sidekick: hide the terminal window" },
                        hide_ctrl_dot = { "<c-.>", "hide"      , mode = "nt", desc = "Sidekick: hide the terminal window" },
                        hide_ctrl_z   = { "<c-z>", "blur"      , mode = "nt", desc = "Sidekick: go back to the previous window without hiding the terminal" },
                        prompt        = { "<c-p>", "prompt"    , mode = "t" , desc = "Sidekick: insert prompt or context" },
                        stopinsert    = { "<c-q>", "stopinsert", mode = "t" , desc = "Sidekick: enter normal mode" },
                        -- Navigate windows in terminal mode. Only active when:
                        -- * layout is not "float"
                        -- * there is another window in the direction
                        -- With the default layout of "right", only `<c-h>` will be mapped
                        nav_left      = { "<M-H>", "nav_left"  , expr = true, desc = "Sidekick: navigate to the left window" },
                        nav_down      = { "<M-J>", "nav_down"  , expr = true, desc = "Sidekick: navigate to the below window" },
                        nav_up        = { "<M-K>", "nav_up"    , expr = true, desc = "Sidekick: navigate to the above window" },
                        nav_right     = { "<M-L>", "nav_right" , expr = true, desc = "Sidekick: navigate to the right window" },
                    },
                    wo = {
                        -- Make the sidekick split fully transparent so it blends with the theme.
                        winblend = 100,
                        winhighlight = "NormalFloat:MyTransparentGroup",
                    },
                    split = {
                        width = 0.3, -- set to 0 for default split width
                    },
                },
                -- Disable tmux/zellij multiplexer integration; sessions live only inside Neovim.
                mux = {
                    enabled = false
                }
            },
        },
        keys = {
            {
                -- NES (Next Edit Suggestion): jump to the next AI-suggested edit location,
                -- or apply the pending suggestion if already there. Falls back to a regular
                -- <Tab> when there is nothing to jump to.
                "<tab>",
                function()
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<Tab>"
                    end
                end,
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
            {
                -- Bring the sidekick window into focus from any mode, or open it if hidden.
                "<c-.>",
                function() require("sidekick.cli").focus() end,
                desc = "Sidekick Focus",
                mode = { "n", "t", "i", "x" },
            },
            {
                -- Toggle the last-used CLI session (show/hide without killing it).
                "<leader>aa",
                function() require("sidekick.cli").toggle() end,
                desc = "Sidekick Toggle CLI",
            },
            {
                -- Open a picker to choose which AI CLI to start or switch to.
                "<leader>as",
                function() require("sidekick.cli").select() end,
                desc = "Select CLI",
            },
            {
                -- Detach (permanently close) the current CLI session.
                "<leader>ad",
                function() require("sidekick.cli").close() end,
                desc = "Detach (close) a CLI Session",
            },
            {
                -- Send the current buffer or visual selection as a @-mention to the CLI.
                -- In normal mode sends the whole file; in visual mode sends the selection.
                "<leader>at",
                function() require("sidekick.cli").send({ msg = "{this}" }) end,
                mode = { "x", "n" },
                desc = "Send This",
            },
            {
                -- Send the current file path as context to the CLI.
                "<leader>af",
                function() require("sidekick.cli").send({ msg = "{file}" }) end,
                desc = "Send File",
            },
            {
                -- Send the current visual selection as context to the CLI.
                "<leader>av",
                function() require("sidekick.cli").send({ msg = "{selection}" }) end,
                mode = { "x" },
                desc = "Send Visual Selection",
            },
            {
                -- Open the prompt/context picker (same as <c-p> inside the terminal).
                "<leader>ap",
                function() require("sidekick.cli").prompt() end,
                mode = { "n", "x" },
                desc = "Sidekick Select Prompt",
            },
            {
                -- Toggle the Claude Code session specifically. claudecode.nvim's WebSocket
                -- server is already running at this point, so the claude process spawned
                -- here will pick up CLAUDE_CODE_SSE_PORT and connect back for IDE features.
                "<leader>ac",
                function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
                desc = "Sidekick Toggle Claude",
            },
        },
    }
}
