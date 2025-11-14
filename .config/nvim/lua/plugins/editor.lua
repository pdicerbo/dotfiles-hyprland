return {

    {
        'echasnovski/mini.ai', version = '*',
        config = function()
            require('mini.ai').setup()
        end

    },

    {
        'echasnovski/mini.move', version = '*',
        config = function()
            require('mini.move').setup()
        end

    },

    {

        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
            -- skip autopair when next character is one of these
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            -- skip autopair when the cursor is inside these treesitter nodes
            skip_ts = { "string" },
            -- skip autopair when next character is closing pair
            -- and there are more closing pairs than opening pairs
            skip_unbalanced = true,
            -- better deal with markdown code blocks
            markdown = true,
        },
        config = function(_, opts)
            require('mini.pairs').setup(opts)
        end,
    },

    {
        'echasnovski/mini.surround', version = '*',
        config = function()
            require('mini.surround').setup()
        end
    },

    -- Split & join
    {
        "echasnovski/mini.splitjoin",
        config = function()
            local miniSplitJoin = require("mini.splitjoin")
            miniSplitJoin.setup({
                mappings = { toggle = "" }, -- Disable default mapping
            })
            vim.keymap.set({ "n", "x" }, "mj", function() miniSplitJoin.join() end, { desc = "Join arguments" })
            vim.keymap.set({ "n", "x" }, "mk", function() miniSplitJoin.split() end, { desc = "Split arguments" })
        end,
    },

    {
        -- automatic highlighting of word under cursor
        "echasnovski/mini.cursorword",
        config = function()
            require("mini.cursorword").setup()
        end,
    },

    {
        "gorbit99/codewindow.nvim",
        config = function()
            local codewindow = require('codewindow')
            codewindow.setup()
            codewindow.apply_default_keybinds()
        end,
    },

    {
        -- Setup Folding with nvim-ufo
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        config = function()
            require("ufo").setup({
                -- treesitter not required
                -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
                -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`-
                provider_selector = function(_, _, _)
                    return { "treesitter", "indent" }
                end,
                open_fold_hl_timeout = 0, -- Disable highlight timeout after opening
            })

            vim.o.foldenable = true
            vim.o.foldcolumn = '0' -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
            vim.o.foldcolumn = '1'

            -- za to fold at cursor location is already enabled
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
            vim.keymap.set('n', 'K', function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    -- choose one of coc.nvim and nvim lsp
                    vim.lsp.buf.hover()
                end
            end, { desc = "Peek Folded Lines" })
        end,
    },

    {
        "tris203/precognition.nvim",
        event = "VeryLazy",
        opts = {
            startVisible = false,
            showBlankVirtLine = false
        },
        vim.keymap.set("n", "<leader>hh", function() require("precognition").toggle() end, { desc = "Toggle Precognition" }),
    }
}
