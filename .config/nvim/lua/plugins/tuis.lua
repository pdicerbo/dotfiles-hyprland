return {
    -- collection of interactive TUIs for Neovim
    'jrop/tuis.nvim',

    keys = { { '<leader>tui', function() require('tuis').choose() end, desc = 'Choose Morph UI (TUI)' }, },

    opts = {},
}
