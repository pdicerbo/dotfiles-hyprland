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


-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
require("vim-options")
-- Setup lazy.nvim
require("lazy").setup("plugins")
vim.lsp.enable('clangd')


-- Git environment setup for bare repo (dotfiles managemen)

-- If you try to open a bare repo (like for managing dotfiles) with neovim, some plugins will complain about not being in a git repo.
-- You can fix this by creating a `.git` file (not directory) that points to your bare repo. Run this command:
-- ```bash
-- echo "gitdir: /home/pierluigi/.dotfiles-bare-repo" > ~/.git
-- ```
-- This tells Git (and any tools using libgit2 or Git commands) where the actual repository is located. This is the standard Git mechanism for detached worktrees and should make Snacks recognize the repo correctly.

local function update_git_env_for_dotfiles()
    -- Define the home directory and the location of your bare repo
    local home = vim.fn.expand("~")
    local git_dir = home .. "/.dotfiles-bare-repo" -- Replace .dotfiles.git with your bare repo name

    -- If GIT_DIR is already set to something, do nothing
    if vim.env.GIT_DIR ~= nil and vim.env.GIT_DIR ~= git_dir then
        return
    end

    -- check if the current working directory should belong to dotfiles
    local cwd = vim.loop.cwd()
    local git_folder = cwd .. "/.git"
    local has_local_git = vim.loop.fs_stat(git_folder) ~= nil

    if (vim.startswith(cwd, home .. "/.config/") or cwd == home) and not has_local_git then
        if vim.env.GIT_DIR == nil then
            -- export git location into ENV
            vim.env.GIT_DIR = git_dir
            vim.env.GIT_WORK_TREE = home
        end
    else
        if vim.env.GIT_DIR == git_dir then
            -- unset variables
            vim.env.GIT_DIR = nil
            vim.env.GIT_WORK_TREE = nil
        end
    end
end

-- Set up an autocommand to run this function when Neovim starts or changes directory
vim.api.nvim_create_autocmd({"VimEnter", "BufEnter", "DirChanged"}, {
    callback = update_git_env_for_dotfiles,
    pattern = {"*"},
})
