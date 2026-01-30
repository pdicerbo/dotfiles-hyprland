return {
    -- manage temporary buffers for code snippets/attempts
    'm-demare/attempt.nvim',
    config = function()
        local attempt = require('attempt')
        attempt.setup()
        vim.keymap.set('n', '<leader>Fn', attempt.new_select, { desc = "Attempt - New Selection" })        -- new attempt, selecting extension
        vim.keymap.set('n', '<leader>Fd', attempt.delete_buf, { desc = "Attempt - Delete Buf" })        -- delete attempt from current buffer
        vim.keymap.set('n', '<leader>Fc', attempt.rename_buf, { desc = "Attempt - Rename Buf" })        -- rename attempt from current buffer
        vim.keymap.set('n', '<leader>Ff', require('attempt.snacks').picker, { desc = "Attempt - Picker" })
    end
}
