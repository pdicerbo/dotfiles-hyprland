return {
    "nvzone/floaterm",
    dependencies = "nvzone/volt",
    opts = {
        border = true,
        mappings = {
            term = function(buf)
                vim.keymap.set({ "n", "t" }, "<C-t>", function()
                    require("floaterm.api").new_term ( { name = "Terminal" } )
                end, { buffer = buf })
                vim.keymap.set("n", "<ESC>", function()
                    require("floaterm").toggle()
                end, { buffer = buf })
            end,
            sidebar = function(buf)
                vim.keymap.set("n", "<ESC>", function()
                    require("floaterm").toggle()
                end, { buffer = buf })
            end,
        },
    },
    cmd = "FloatermToggle",
    keys = {
        { "<leader>tf", "<cmd>FloatermToggle<cr>", desc = "Toggle Floaterm terminal" },
    },
}
