-- cppman
return {
	'madskjeldgaard/cppman.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
	config = function()
		local cppman = require("cppman")
		cppman.setup()

		-- Make a keymap to open the word under cursor in CPPman
		vim.keymap.set("n", "<leader>cw", function()
			cppman.open_cppman_for(vim.fn.expand("<cword>"))
		end, { desc = "open cppman for selected word" } )

		-- Open search box
		vim.keymap.set("n", "<leader>cpp", function()
			cppman.input()
		end, { desc = "open cppman" })

	end
}
