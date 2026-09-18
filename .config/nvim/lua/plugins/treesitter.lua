local treesitter_context = {
    "nvim-treesitter/nvim-treesitter-context",

    config = function()
        require'treesitter-context'.setup{
            enable = false, -- Disabled by default
            multiline_threshold = 10, -- Maximum number of lines to show for a single context
        }
    end,

    keys = {
        { "<leader>bs", "<cmd>TSContext toggle<cr>", desc = "toggle treesitter context (aka sticky scroll breadcrumbs)" },
    },

}

local treesitter_text_object = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'VeryLazy',

    branch = 'main',

    keys = {
        {
            '[f',
            function() require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects') end,
            desc = 'prev function',
            mode = { 'n', 'x', 'o' },
        },
        {
            ']f',
            function() require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects') end,
            desc = 'next function',
            mode = { 'n', 'x', 'o' },
        },
        {
            '[F',
            function() require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects') end,
            desc = 'prev function end',
            mode = { 'n', 'x', 'o' },
        },
        {
            ']F',
            function() require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects') end,
            desc = 'next function end',
            mode = { 'n', 'x', 'o' },
        },
        {
            '[a',
            function() require('nvim-treesitter-textobjects.move').goto_previous_start('@parameter.outer', 'textobjects') end,
            desc = 'prev argument',
            mode = { 'n', 'x', 'o' },
        },
        {
            ']a',
            function() require('nvim-treesitter-textobjects.move').goto_next_start('@parameter.outer', 'textobjects') end,
            desc = 'next argument',
            mode = { 'n', 'x', 'o' },
        },
        {
            '[A',
            function() require('nvim-treesitter-textobjects.move').goto_previous_end('@parameter.outer', 'textobjects') end,
            desc = 'prev argument end',
            mode = { 'n', 'x', 'o' },
        },
        {
            ']A',
            function() require('nvim-treesitter-textobjects.move').goto_next_end('@parameter.outer', 'textobjects') end,
            desc = 'next argument end',
            mode = { 'n', 'x', 'o' },
        },
        {
            '[s',
            function() require('nvim-treesitter-textobjects.move').goto_previous_start('@block.outer', 'textobjects') end,
            desc = 'prev block',
            mode = { 'n', 'x', 'o' },
        },
        {
            ']s',
            function() require('nvim-treesitter-textobjects.move').goto_next_start('@block.outer', 'textobjects') end,
            desc = 'next block',
            mode = { 'n', 'x', 'o' },
        },
        {
            '[S',
            function() require('nvim-treesitter-textobjects.move').goto_previous_end('@block.outer', 'textobjects') end,
            desc = 'prev block',
            mode = { 'n', 'x', 'o' },
        },
        {
            ']S',
            function() require('nvim-treesitter-textobjects.move').goto_next_end('@block.outer', 'textobjects') end,
            desc = 'next block',
            mode = { 'n', 'x', 'o' },
        },
        {
            'gan',
            function() require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner') end,
            desc = 'swap next argument',
        },
        {
            'gap',
            function() require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner') end,
            desc = 'swap prev argument',
        },
    },

    opts = {
        move = {
            enable = true,
            set_jumps = true,
        },
        swap = {
            enable = true,
        },
    },
}

local treesitter_languages = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "css",
    "csv",
    "cuda",
    "diff",
    "dockerfile",
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "go",
    "hyprlang",
    "ini",
    "html",
    "json",
    "javascript",
    "llvm",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "proto",
    "python",
    'query',
    "regex",
    "rst",
    "rust",
    "scss",
    "ssh_config",
    "strace",
    "svelte",
    "tsx",
    "typst",
    "tmux",
    "vim",
    "vimdoc",
    "vue",
    "xresources",
    "yaml"
}

-- Compat shim: nvim-treesitter's custom query directives (query_predicates.lua:
-- set-lang-from-info-string!, set-lang-from-mimetype!, downcase!, ...) assume a
-- query capture always resolves to a single TSNode and call
-- vim.treesitter.get_node_text(node, ...) directly on it. On this Neovim
-- version, query-match captures can come back as a *list* of nodes instead;
-- nvim-treesitter's own compat shim for that (`{ all = false }`) doesn't fully
-- prevent it, so `node` ends up being a one-element list, and
-- get_node_text -> get_range crashes with "attempt to call method 'range'
-- (a nil value)" -- e.g. when resolving the language of a ```lang fenced code
-- block in a markdown file (queries/markdown/injections.scm uses
-- set-lang-from-info-string!). That crash takes down the shared treesitter
-- decoration provider (ALL highlighting, not just the buffer being parsed)
-- until <leader>Tr or a restart. Unwrap defensively at the one choke point
-- every affected directive funnels through, so this never reaches get_range.
do
    local orig_get_node_text = vim.treesitter.get_node_text
    vim.treesitter.get_node_text = function(node, source, opts)
        if type(node) == 'table' and node.range == nil then
            node = node[1]
        end
        if node == nil then return '' end
        return orig_get_node_text(node, source, opts)
    end
end

-- Recover from a crashed treesitter highlighter without a full nvim restart.
-- Neovim registers ONE global decoration provider for treesitter highlighting
-- at startup; if a callback errors (e.g. a language-injection bug triggered by
-- some plugin parsing a buffer), nvim disables that provider for the rest of
-- the session and highlighting drops out everywhere, even in unrelated buffers.
-- Reloading the highlighter module re-registers it.
-- NOTE: this must be registered before the branch-dependent early `return`
-- below, since it relies only on the built-in `vim.treesitter` API and needs
-- to work on both the `main` and `master` nvim-treesitter branches.
vim.keymap.set('n', '<leader>Tr', function()
    -- `vim.treesitter` caches its `.highlighter` submodule as a plain field the
    -- first time it's accessed (see vim._defer_require): dropping the cache and
    -- clearing package.loaded forces a fresh require (and re-registration of the
    -- decoration provider) the next time anything touches vim.treesitter.highlighter.
    package.loaded['vim.treesitter.highlighter'] = nil
    (vim.treesitter --[[@as table]]).highlighter = nil

    local ok, err = pcall(function() return vim.treesitter.highlighter end)
    if not ok then
        vim.notify('Failed to reload treesitter highlighter: ' .. err, vim.log.levels.ERROR)
        return
    end

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            pcall(vim.treesitter.stop, buf)
            pcall(vim.treesitter.start, buf)
        end
    end

    vim.notify('Treesitter highlighter reloaded', vim.log.levels.INFO)
end, { desc = 'Restart treesitter highlighting engine (recover from a crash without restarting nvim)' })

if vim.g.treesitter_branch ~= 'main' then return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "master",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = treesitter_languages,
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                additional_vim_regex_highlighting = false,
            })
        end
    },
    treesitter_context,
    treesitter_text_object,
} end

-- on main branch, treesitter isn't started automatically
vim.api.nvim_create_autocmd({ 'Filetype' }, {
    callback = function(event)
        -- make sure nvim-treesitter is loaded
        local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')

        -- no nvim-treesitter, maybe fresh install
        if not ok then return end

        local parsers = require('nvim-treesitter.parsers')

        if not parsers[event.match] or not nvim_treesitter.install then return end

        local ft = vim.bo[event.buf].ft
        local lang = vim.treesitter.language.get_lang(ft)
        nvim_treesitter.install({ lang }):await(function(err)
            if err then
                vim.notify('Treesitter install error for ft: ' .. ft .. ' err: ' .. err)
                return
            end

            pcall(vim.treesitter.start, event.buf)
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

            -- Don't impose treesitter folding on diff windows (Claude Code diffs,
            -- :diffsplit, fugitive, etc.) — let native foldmethod=diff stand.
            if vim.wo.diff then return end

            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo.foldmethod = 'expr'
        end)
    end,
})

return {
    ---@module 'lazy'
    ---@type LazySpec
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        -- event = 'VeryLazy',
        dependencies = {
            { 'folke/ts-comments.nvim', opts = {} },
        },

        branch = 'main',
        build = function()
            -- update parsers, if TSUpdate exists
            if vim.fn.exists(':TSUpdate') == 2 then vim.cmd('TSUpdate') end
        end,

        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
        ---@module 'nvim-treesitter'
        ---@type TSConfig
        ---@diagnostic disable-next-line: missing-fields

        config = function(_, _)

            -- make sure nvim-treesitter can load
            local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')

            -- no nvim-treesitter, maybe fresh install
            if not ok then return end
            nvim_treesitter.install(treesitter_languages)
        end,
    },
    treesitter_context,
    treesitter_text_object,

}
