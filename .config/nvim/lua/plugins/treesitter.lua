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
    "jsonc",
    "javascript",
    "llvm",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "norg",
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
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = "<C-s>",
                        node_decremental = "<C-backspace>",
                    },
                },
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
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
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
