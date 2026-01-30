return {

    {
        -- Code minimap
        "gorbit99/codewindow.nvim",
        config = function()
            local codewindow = require('codewindow')
            codewindow.setup()
            codewindow.apply_default_keybinds()
        end,
    },

    {
        -- Setup Folding with nvim-ufo:
        -- make Neovim's fold look modern and keep high performance.
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
        -- discovering motions (Both vertical and horizontal) to navigate your current buffer
        "tris203/precognition.nvim",
        event = "VeryLazy",
        opts = {
            startVisible = false,
            showBlankVirtLine = false
        },
        vim.keymap.set("n", "<leader>hh", function() require("precognition").toggle() end, { desc = "Toggle Precognition" }),
    },

    {
        -- automatically toggle between relative and absolute line numbers
        "sitiom/nvim-numbertoggle"
    },
}
