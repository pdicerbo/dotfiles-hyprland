return {
   "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("cmake-tools").setup({
            cmake_build_directory = "build",
            -- cmake_soft_link_compile_commands = false,
            cmake_generate_options = {
                "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
                "-DCMAKE_C_COMPILER=clang",
                "-DCMAKE_CXX_COMPILER=clang++ ",
                -- "-G Ninja",
                "-DCMAKE_BUILD_TYPE=RelWithDebInfo",
                "-DCMAKE_INSTALL_PREFIX=../install"
            },
            cmake_build_options = {
                "--parallel"
            },
            cmake_executor = {
                name = "quickfix", -- name of the executor
                opts = {
                    show = "always",
                    position = "belowright",
                    size = 20,
                    auto_close_when_success = true,
                }
            },
            cmake_runner = {
                name = "quickfix", -- name of the runner
                opts = {
                    show = "always",
                    position = "belowright",
                    size = 20,
                    auto_close_when_success = true,
                }
            },
        })

        vim.keymap.set("n", "<F7>",         ":CMakeBuild<CR>",           { desc = "CMake Build project" })
        vim.keymap.set("n", "<leader>cb",   ":CMakeBuild<CR>",           { desc = "CMake Build project" })
        vim.keymap.set("n", "<leader>cB",   ":CMakeBuild!<CR>",          { desc = "CMake Rebuild project" })
        vim.keymap.set("n", "<leader>cg",   ":CMakeGenerate<CR>",        { desc = "CMake Generate project" })
        vim.keymap.set("n", "<leader>cG",   ":CMakeGenerate!<CR>",       { desc = "CMake Reconfigure project" })
        vim.keymap.set("n", "<leader>cI",   ":CMakeInstall<CR>",         { desc = "CMake Install project" })
        vim.keymap.set("n", "<F8>",         ":CMakeInstall<CR>",         { desc = "CMake Install project" })
        vim.keymap.set('n', '<leader>cs', function() require("lazy").reload({ plugins = { "cmake-tools.nvim" } }) vim.cmd("CMakeSelectCwd") end, { desc = "Reload cmake-tools and select CMake file" })
        vim.keymap.set("n", "<leader>ct",   ":CMakeRunTest<CR>",         { desc = "CMake Run Test" })
        vim.keymap.set("n", "<leader>cT",   ":CMakeSelectBuildType<CR>", { desc = "CMake Select Build Type" })
        vim.keymap.set("n", "<leader>cS",   ":CMakeSettings<CR>",        { desc = "CMake Settings" })
        vim.keymap.set("n", "<leader>cx",   ":CMakeClean<CR>",           { desc = "CMake Clean all targets" })
        vim.keymap.set("n", "<leader>cQ",   ":CMakeStopExecutor<CR>",    { desc = "CMake Stop execution" })
    end,
}
