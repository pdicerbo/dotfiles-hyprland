local prompts = {
    -- Code related prompts
    Explain = "Please explain how the following code works.",
    Review = "Please review the following code and provide suggestions for improvement.",
    Tests = "Please explain how the selected code works, then generate unit tests for it.",
    Refactor = "Please refactor the following code to improve its clarity and readability.",
    FixCode = "Please fix the following code to make it work as intended.",
    FixError = "Please explain the error in the following text and provide a solution.",
    BetterNamings = "Please provide better names for the following variables and functions.",
    Documentation = "Please provide documentation for the following code.",
    SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
    SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
    -- Text related prompts
    Summarize = "Please summarize the following text.",
    Spelling = "Please correct any grammar and spelling errors in the following text.",
    Wording = "Please improve the grammar and wording of the following text.",
    Concise = "Please rewrite the following text to make it more concise.",
}

return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        -- optional = true,
        opts = {
            file_types = { "markdown", "copilot-chat", "codecompanion" },
        },
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
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            question_header = "## User ",
            answer_header = "## Copilot ",
            error_header = "## Error ",
            prompts = prompts,
            model = "gpt-4.1", -- default model
            resources = {
                'buffer',
                'selection'
            },
            window = {
                layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace', or a function that returns the layout
                width = 0.3, -- fractional width of parent, or absolute width in columns when > 1
                height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
                -- Options below only apply to floating windows
                relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
                border = 'solid', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
                row = nil, -- row position of the window, default is centered
                col = nil, -- column position of the window, default is centered
                title = 'Copilot Chat', -- title of chat window
                footer = nil, -- footer of chat window
                zindex = 1, -- determines if window is on top or below other floating windows
            },
            auto_insert_mode = true, -- automatically enter insert mode when opening the window
            mappings = {
                -- Use tab for completion
                complete = {
                    detail = "Use @<Tab> or /<Tab> for options.",
                    insert = "<S-Tab>",
                },
                -- Close the chat
                close = {
                    normal = "q",
                    insert = "<C-c>",
                },
                -- Reset the chat buffer
                reset = {
                    normal = "<C-x>",
                    insert = "<C-x>",
                },
                -- Submit the prompt to Copilot
                submit_prompt = {
                    normal = "<CR>",
                    insert = "<CR>",
                },
                -- Accept the diff
                accept_diff = {
                    normal = "<C-y>",
                    insert = "<C-y>",
                },
                -- Show help
                show_help = {
                    normal = "g?",
                },
            },
        },
        config = function(_, opts)
            local chat = require("CopilotChat")
            chat.setup(opts)

            local select = require("CopilotChat.select")
            -- Inline chat with Copilot
            vim.api.nvim_create_user_command("CopilotChatInline", function(args)
                chat.ask(args.args, {
                    selection = select.visual,
                    window = {
                        layout = "float",
                        relative = "cursor",
                        width = 0.7,
                        height = 0.4,
                        row = 1,
                    },
                })
            end, { nargs = "*", range = true })

            -- Restore CopilotChatBuffer
            vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
                chat.ask(args.args, { selection = select.buffer })
            end, { nargs = "*", range = true })

            -- Custom buffer for CopilotChat
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-*",
                callback = function()
                    vim.opt_local.relativenumber = true
                    vim.opt_local.number = true
                end,
            })
        end,
        event = "VeryLazy",
        keys = {
            -- Show prompts actions with telescope
            {
                "<leader>cp",
                function()
                    require("CopilotChat").select_prompt({
                        context = {
                            "buffers",
                        },
                    })
                end,
                mode = "n",
                desc = "CopilotChat - Prompt actions",
            },
            {
                "<leader>cp",
                function()
                    require("CopilotChat").select_prompt()
                end,
                mode = "x",
                desc = "CopilotChat - Prompt actions",
            },
            -- Code related commands
            -- { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
            -- { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
            -- { "<leader>cr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
            -- { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
            -- { "<leader>cn", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
            -- { "<leader>cm", "<cmd>CopilotChatCommit<cr>", desc = "CopilotChat - Generate commit message for all changes", },
            -- { "<leader>cA", "<cmd>CopilotChatAgents<cr>", desc = "CopilotChat - Select Agents" },

            -- Inline chat with Copilot
            {
                "<leader>ci",
                ":CopilotChatInline ",
                mode = { "n", "x" },
                desc = "CopilotChat - Inline chat",
            },
            -- Custom input for CopilotChat
            {
                "<leader>ai",
                function()
                    local input = vim.fn.input("Ask Copilot: ")
                    if input ~= "" then
                        vim.cmd("CopilotChat " .. input)
                    end
                end,
                desc = "CopilotChat - Ask input",
            },
            -- Quick chat with Copilot
            {
                "<leader>cq",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        vim.cmd("CopilotChatBuffer " .. input)
                    end
                end,
                desc = "CopilotChat - Quick chat",
            },
            -- Fix the issue with diagnostic
            { "<leader>cf", "<cmd>CopilotChatFixError<cr>", desc = "CopilotChat - Fix Diagnostic" },
            -- Clear buffer and chat history
            { "<leader>cl", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
            -- Save chat
            {
                "<leader>cS",
                function()
                    local input = vim.fn.input("Save chat as: ")
                    if input ~= "" then
                        require("CopilotChat").save(input)
                    end
                end,
                desc = "CopilotChat - Save chat",
            },
            -- Load chat
            {
                "<leader>cL",
                function()
                    local history_path = vim.fn.stdpath("data") .. "/copilotchat_history"
                    local files = vim.fn.glob(history_path .. "/*.json", false, true)

                    if #files == 0 then
                        vim.notify("No saved chats found", vim.log.levels.WARN)
                        return
                    end

                    local chat_names = {}
                    for _, file in ipairs(files) do
                        local name = vim.fn.fnamemodify(file, ":t:r")
                        table.insert(chat_names, name)
                    end

                    vim.ui.select(chat_names, {
                        prompt = "Select a chat to load:",
                    }, function(choice)
                        if choice then
                            require("CopilotChat").load(choice)
                        end
                    end)
                end,
                desc = "CopilotChat - Load chat",
            },
            -- Delete chat
            {
                "<leader>cD",
                function()
                    local history_path = vim.fn.stdpath("data") .. "/copilotchat_history"
                    local files = vim.fn.glob(history_path .. "/*.json", false, true)

                    if #files == 0 then
                        vim.notify("No saved chats found", vim.log.levels.WARN)
                        return
                    end

                    local chat_names = {}
                    for _, file in ipairs(files) do
                        local name = vim.fn.fnamemodify(file, ":t:r")
                        table.insert(chat_names, name)
                    end

                    vim.ui.select(chat_names, {
                        prompt = "Select a chat to delete:",
                    }, function(choice)
                        if choice then
                            local file_path = history_path .. "/" .. choice .. ".json"
                            if vim.fn.delete(file_path) == 0 then
                                vim.notify("Deleted chat: " .. choice, vim.log.levels.INFO)
                            else
                                vim.notify("Failed to delete chat: " .. choice, vim.log.levels.ERROR)
                            end
                        end
                    end)
                end,
                desc = "CopilotChat - Delete chat",
            },
            -- Toggle Copilot Chat Vsplit
            { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
            -- Copilot Chat Models
            { "<leader>c?", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
        },
    },

    {
        "olimorris/codecompanion.nvim",
        -- version = "^18.0.0",
        event = "VeryLazy",
        opts = {
            display = {
                action_palette = {
                    provider = "snacks"
                },
                chat = {
                    window = {
                        position = "right", -- left, right, top, bottom, float
                        width = 0.3,
                    },
                    auto_scroll = false,
                    show_settings = true,
                }
            },
            interactions = {
                chat = {
                    slash_commands = {
                        ["file"] = {
                            description = "Select a file using Snacks",
                            keymaps = {
                                modes = {
                                    i = "<C-x>",
                                    n = "<C-x>",
                                },
                            },
                            opts = {
                                provider = "snacks", -- options 'default', 'mini_pick', 'fzf_lua', snacks
                                contains_code = true,
                            },
                        },
                        ["buffer"] = {
                            description = "Select a buffer using Snacks",
                            keymaps = {
                                modes = {
                                    i = "<C-x>",
                                    n = "<C-x>",
                                },
                            },
                            opts = {
                                provider = "snacks", -- options 'default', 'mini_pick', 'fzf_lua', snacks
                                contains_code = true,
                            },
                        },
                    },
                    -- keymaps = {
                    --     completion = {
                    --         modes = {
                    --             i = "<C-x>",
                    --             n = { "<C-x>" },
                    --         },
                    --     }
                    -- }
                }
            }
        },

        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "hrsh7th/nvim-cmp",
        },

        keys = {
            { "<leader>ac","<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true }, desc = "Code Companion - Action Palette", },
            { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, { noremap = true, silent = true }, desc = "Code Companion - Toggle Chat Window"},

        },
    }

}
