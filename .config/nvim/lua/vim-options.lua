vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.background = "dark"
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.clipboard:append ("unnamedplus") -- Copy paste between vim and everything else
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.hlsearch = true -- Highlight all matches on previous search pattern
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.number = true -- Print line number
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.showmode = false -- Dont show mode since we have a statusline
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.softtabstop = 4
vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true -- Split horizontally to the bottom
vim.opt.splitright = true -- Split vertically to the right
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.winborder = 'rounded'
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Shift visual selected lines
vim.keymap.set( "v", "<M-j>",       ":m '>+1<CR>gv=gv", { desc = "Shift visual selected lines down" } ) -- Shift visual selected lines down
vim.keymap.set( "v", "<M-k>",       ":m '<-2<CR>gv=gv", { desc = "Shift visual selected lines up" } ) -- Shift visual selected lines up
vim.keymap.set( "v", "<M-Down>",    ":m '>+1<CR>gv=gv", { desc = "Shift visual selected lines down" } ) -- Shift visual selected lines down
vim.keymap.set( "v", "<M-Up>",      ":m '<-2<CR>gv=gv", { desc = "Shift visual selected lines up" } ) -- Shift visual selected lines up
vim.keymap.set( "n", "<C-a>",       "gg<S-v>G", { desc = "Select all lines in buffer (overrides default <C-a> behavior, i.e. incrementing the number under cursor)" }) -- Select all lines in buffer

-- shift+arrow selection
vim.keymap.set( "n", "<S-Up>",      "v<Up>",            { desc = "shift+Up arrow selection (normal mode)" })
vim.keymap.set( "n", "<S-Down>",    "v<Down>",          { desc = "shift+Down arrow selection (normal mode)" })
vim.keymap.set( "v", "<S-Up>",      "<Up>",             { desc = "shift+Up arrow selection (visual mode)" })
vim.keymap.set( "v", "<S-Down>",    "<Down>",           { desc = "shift+Down arrow selection (visual mode)" })
vim.keymap.set( "v", "<S-Left>",    "<Left>",           { desc = "shift+Left arrow selection (visual mode)" })
vim.keymap.set( "v", "<S-Right>",   "<Right>",          { desc = "shift+Right arrow selection (visual mode)" })
vim.keymap.set( "i", "<S-Up>",      "<Esc>v<Up>",       { desc = "shift+Up arrow selection (insert mode)" })
vim.keymap.set( "i", "<S-Down>",    "<Esc>v<Down>",     { desc = "shift+Down arrow selection (insert mode)" })
vim.keymap.set( "i", "<S-Left>",    "<Esc>v<Left>",     { desc = "shift+Left arrow selection (insert mode)" })
vim.keymap.set( "i", "<S-Right>",   "<Esc>v<Right>",    { desc = "shift+Right arrow selection (insert mode)" })

-- delete previous word in insert mode
-- delete previous word in insert mode and normal mode
vim.keymap.set("i", "<C-h>", "<C-w>", { desc = "Delete previous word in insert mode" })
vim.keymap.set("n", "<C-h>", "db", { desc = "Delete previous word in normal mode" })

-- delete next word in insert mode and normal mode
vim.keymap.set("i", "<C-Del>", "<C-o>dw", { desc = "Delete next word in insert mode" })
vim.keymap.set("n", "<C-Del>", "dw", { desc = "Delete next word in normal mode" })

-- Join next line with the current one keeping the cursor in the same position
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the middle of the screen when jumping up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- move selected lines left and right without losing selection
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- prevent x delete from registering when next paste
vim.keymap.set("n", "x", '"_x', opts)

-- format without prettier using the built in
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Replace the word cursor is on globally
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word cursor is on globally" })

-- split management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>so", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- toggle line wrap
vim.keymap.set("n", "<leader>wl", "<cmd>set wrap!<CR>", { desc = "Toggle line wrap" })

-- reopen latest buffer (historically used)
vim.keymap.set("n", "<leader>bb", "<cmd>b#<CR>", { desc = "Reopen latest buffer" })

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.trc", "*.log"},
    callback = function()
        vim.bo.filetype = "systemverilog"
    end,
})

-- Automatically update Copilot workspace folder on directory change
vim.api.nvim_create_autocmd("DirChanged", {
    callback = function(args)
        vim.g.copilot_workspace_folders = { vim.fn.getcwd() }
        if vim.fn.exists(":Copilot") == 2 then
            vim.cmd("Copilot restart")
        end
    end,
})
