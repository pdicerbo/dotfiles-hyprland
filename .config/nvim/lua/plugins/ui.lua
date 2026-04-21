return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    progress = {
                        enabled = true,
                    },
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            })
        end
    },

    {
        "akinsho/bufferline.nvim",
        lazy = false,
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
            { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
            { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
            { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
            { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
            { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
            { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
        },
        opts = {
            options = {
                -- stylua: ignore
                close_command = function(n) Snacks.bufdelete(n) end,
                -- stylua: ignore
                right_mouse_command = function(n) Snacks.bufdelete(n) end,
                diagnostics = "nvim_lsp",
                always_show_bufferline = true,
                -- diagnostics_indicator = function(_, _, diag)
                --   local icons = LazyVim.config.icons.diagnostics
                --   local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                --     .. (diag.warning and icons.Warn .. diag.warning or "")
                --   return vim.trim(ret)
                -- end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                    {
                        filetype = "snacks_layout_box",
                    },
                },

                show_buffer_icons = true,
                separator_style = "slant",
                sort_by = 'insert_after_current',

                ---@param opts bufferline.IconFetcherOpts
                -- get_element_icon = function(opts)
                --   return LazyVim.config.icons.ft[opts.filetype]
                -- end,
            },
        },
        config = function(_, opts)
            require("bufferline").setup(opts)
            -- Fix bufferline when restoring a session
            vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
                callback = function()
                    vim.schedule(function()
                        pcall(nvim_bufferline)
                    end)
                end,
            })
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local lualine = require("lualine")
            local lazy_status = require("lazy.status") -- to configure lazy pending updates count
            local mode = {
                'mode',
                fmt = function(str)
                    -- return ' '
                    -- displays only the first character of the mode
                    return ' ' .. str
                end,
            }

            local diff = {
                'diff',
                colored = true,
                symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
                -- cond = hide_in_width,
            }

            local filename = {
                'filename',
                file_status = true,
                path = 0,
            }

            local branch = {'branch', icon = {'', color={fg='#A6D4DE'}}, '|'}


            lualine.setup({
                icons_enabled = true,
                options = {
                    theme = "auto",
                },
                sections = {
                    lualine_a = { mode },
                    lualine_b = { branch },
                    lualine_c = { diff, filename },
                    lualine_x = {
                        {
                            require("noice").api.status.mode.get,
                            cond = require("noice").api.status.mode.has,
                            color = { fg = "#ff9e64" },
                        },
                        {
                            require("noice").api.status.search.get,
                            cond = require("noice").api.status.search.has,
                            color = { fg = "#ff9e64" },
                        },
                        {
                            lazy_status.updates,
                            cond = lazy_status.has_updates,
                            color = { fg = "#ff9e64" },
                        },
                        { "encoding",},
                        { "fileformat" },
                        { "filetype" },
                        {
                            function()
                                local status = require("sidekick.status").get()
                                return status and "🤖 " or ""
                            end,
                            color = function()
                                local status = require("sidekick.status")
                                return status.get() and status.get().busy and "DiagnosticWarn" or "Special"
                            end,
                            cond = function()
                                local status = require("sidekick.status")
                                return status.get() ~= nil
                            end
                        },
                        {
                            function()
                                local status = require("sidekick.status").cli()
                                return " " .. (#status > 1 and #status or "")
                            end,
                            cond = function()
                                return #require("sidekick.status").cli() > 0
                            end,
                            color = function()
                                return "Special"
                            end,
                        }
                    },
                },

            })
        end,
    },

    {
        "sphamba/smear-cursor.nvim",
        opts = {
            cursor_color = "#00ffde",
            gamma = 1,
            smear_terminal_mode = true,
            stiffness = 0.6,
            trailing_stiffness = 0.3,
            trailing_exponent = 5,
        },
    },

    {
        'wsdjeg/calendar.nvim',
        lazy = true,
        keys = {
            { "<leader>cal", "<Cmd>Calendar<CR>", desc = "Open Calendar" },
        },
    },

}
