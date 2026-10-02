return {
    'blackhat-7/vellum.nvim',
    ft = 'markdown',
    keys = {
        { '<leader>MP', '<cmd>Vellum<cr>',                       desc = 'Markdown preview' },
        { '<leader>MZ', function() require('vellum').zoom() end, desc = 'Markdown zoom' },
    },
    opts = {},
}
