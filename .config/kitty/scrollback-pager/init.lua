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

-- Avoid modifiable = off in order to use flash to jump into the buffer,
-- therefore block accidental edits without breaking plugins
for _, key in ipairs({ "i", "I", "a", "A", "o", "O", "c", "C" }) do
    vim.keymap.set("n", key, "<nop>")
end

-- Keep cursor in the middle of the screen when jumping up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "q", ":q<CR>")

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
})

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
        {
            "folke/flash.nvim",
            lazy = false,
            ---@type Flash.Config
            opts = {
                search = {
                    multi_window = false,
                },
            },
            -- stylua: ignore
            keys = {
                { "s", mode = { "n", "x", "o" }, function()
                    local ok = pcall(require("flash").jump)
                    if not ok then vim.schedule(function() require("flash").jump() end) end
                end, desc = "Flash" },
            },
        }
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

-- Suppress flash's "Invalid cursor column" redraw errors (flash still works correctly)
local orig_notify = vim.notify
vim.notify = function(msg, level, opts)
    if type(msg) == "string" and msg:find("Flash error during redraw") then return end
    orig_notify(msg, level, opts)
end

-- FlashMatch: the characters that matched your search
-- FlashLabel: the jump label shown on top
-- FlashCurrent: the currently selected match
vim.api.nvim_set_hl(0, "FlashMatch",   { bg = "#ffaa00", fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "FlashLabel",   { bg = "#ff007c", fg = "#ffffff", bold = true })
vim.api.nvim_set_hl(0, "FlashCurrent", { bg = "#00aaff", fg = "#000000", bold = true })
