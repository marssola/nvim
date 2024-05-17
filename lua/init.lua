-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require("nvim-tree").setup({
        sort = {
            sorter = "case_sensitive",
        },
        git = {
            enable = true,
        },
        renderer = {
            group_empty = true,
            highlight_git = true,
            icons = {
                show = {
                    git = true,
                },
            },
            special_files = {
                "Cargo.toml",
                "Makefile",
                "README.md",
                "readme.md",
                "CMakeLists.txt",
                "CHANGELOG.md",
            },
        },
        filters = {
            dotfiles = false,
        },
        view = {
            width = 50,
        },
    })

require("nvim-autopairs").setup {}
require'colorizer'.setup()
require('plugins/lualine')
require('plugins/treesitter')
require('plugins/indent-blankline')
require('plugins/ts-autotag')
require('Comment').setup()

require('auto-session').setup()

local bufferline = require('bufferline')
bufferline.setup({
        options = {
            style_preset = bufferline.style_preset.no_italic,
            -- or you can combine these e.g.
            style_preset = {
                bufferline.style_preset.no_italic,
                bufferline.style_preset.no_bold
            },
        }
    })
