return {
    'm-demare/attempt.nvim',
    keys = {
        { '<leader>Fn', function() require('attempt').new_select() end, desc = "Attempt - New Selection" },
        { '<leader>Fd', function() require('attempt').delete_buf() end, desc = "Attempt - Delete Buf" },
        { '<leader>Fc', function() require('attempt').rename_buf() end, desc = "Attempt - Rename Buf" },
        { '<leader>Ff', function() require('attempt.snacks').picker() end, desc = "Attempt - Picker" },
    },
    config = function()
        require('attempt').setup()
    end
}
