return {
    -- manage temporary buffers for code snippets/attempts
    'm-demare/attempt.nvim',
    config = function()
        local attempt = require('attempt')
        attempt.setup()
        vim.keymap.set('n', '<leader>Fn', attempt.new_select)        -- new attempt, selecting extension
        -- vim.keymap.set('n', '<leader>Fi', attempt.new_input_ext)     -- new attempt, inputing extension
        -- vim.keymap.set('n', '<leader>Fr', attempt.run)               -- run attempt
        vim.keymap.set('n', '<leader>Fd', attempt.delete_buf)        -- delete attempt from current buffer
        vim.keymap.set('n', '<leader>Fc', attempt.rename_buf)        -- rename attempt from current buffer
        vim.keymap.set('n', '<leader>Ff', require('attempt.snacks').picker)
    end
}
