vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

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
vim.opt.readonly = true
vim.opt.modifiable = false

-- Keep cursor in the middle of the screen when jumping up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "q", ":q<CR>")

-- toggle line wrap
vim.keymap.set("n", "<leader>wl", "<cmd>set wrap!<CR>", { desc = "Toggle line wrap" })

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup(
    {
        -- Add plugins here, for example:
        {
            "typicode/bg.nvim", lazy = false
        },
    },
    {
        -- Lazy configuration
        install = { colorscheme = { "default" } },
        checker = { enabled = false },
        performance = {
            rtp = {
                disabled_plugins = {
                    "gzip", "matchit", "matchparen", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin",
                },
            },
        },
    })
