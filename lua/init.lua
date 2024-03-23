require('nvim-tree').setup({
 hijack_cursor = false,
 renderer = {
  indent_markers = {
    enable = true,
  },
 },
})

require("nvim-autopairs").setup {}
require("nvim-tree")
require'colorizer'.setup()
require('plugins/lualine')
require('plugins/treesitter')
require('plugins/indent-blankline')
require('plugins/ts-autotag')
require('Comment').setup()
require('auto-session').setup()
