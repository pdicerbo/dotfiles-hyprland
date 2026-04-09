return {
   "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    opts = {
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
                "--parallel 14"
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
    },
    keys = {
        { "<F7>",         ":CMakeBuild<CR>",           desc = "CMake Build project" },
        { "<F8>",         ":CMakeInstall<CR>",         desc = "CMake Install project" },
        { '<leader>cs', function() require("lazy").reload({ plugins = { "cmake-tools.nvim" } }) vim.cmd("CMakeSelectCwd") end, desc = "Reload cmake-tools and select CMake file" },
        { "<leader>ct",   ":CMakeRunTest<CR>",         desc = "CMake Run Test" },
        { "<leader>cT",   ":CMakeSelectBuildType<CR>", desc = "CMake Select Build Type" },
        { "<leader>cQ",   ":CMakeStopExecutor<CR>",    desc = "CMake Stop execution" },
    }
}
