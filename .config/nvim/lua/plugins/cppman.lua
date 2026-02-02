-- cppman
return {
	'madskjeldgaard/cppman.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },

	keys = {
		{ "<leader>cw", function() require("cppman").open_cppman_for(vim.fn.expand("<cword>")) end, desc = "open cppman for selected word" },
		{ "<leader>cpp", function() require("cppman").input() end, desc = "open cppman" },
	},

	config = function()
		require("cppman").setup()
	end
}
