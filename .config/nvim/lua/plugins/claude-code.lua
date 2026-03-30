return {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    opts = {
		terminal = {
			snacks_win_opts = {
                wo = {
                    winblend = 100,
                    winhighlight = "NormalFloat:MyTransparentGroup",
                }
			},
		},
	},
    keys = {
        { "<leader>a", "",                                     desc = "AI/Claude Code", mode = { "n", "v" } },
        { "<leader>ac", "<cmd>ClaudeCode<cr>",                 desc = "Toggle Claude Code" },
        { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",            desc = "Focus Claude Code" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",        desc = "Resume Claude Code" },
        { "<leader>aC", "<cmd>ClaudeCode --continue<cr>",      desc = "Continue Claude Code" },
        { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>",      desc = "Select Claude Code model" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",            desc = "Add current buffer" },
        { "<leader>as", "<cmd>ClaudeCodeSend<cr>",             desc = "Send to Claude Code", mode = "v",},
        {
            "<leader>as",
            "<cmd>ClaudeCodeTreeAdd<cr>",
            desc = "Add file",
            ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
        },
        -- Diff management
        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
        { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
}
