return {
    -- collection of interactive TUIs for Neovim
    'jrop/tuis.nvim',
    config = function()
        -- Optional: set up keymaps
        vim.keymap.set('n', '<leader>tui', function()
            require('tuis').choose()
        end, { desc = 'Choose Morph UI (TUI)' })
    end
}
