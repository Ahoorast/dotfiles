-- windwp/nvim-ts-autotag -- auto close/rename HTML/JSX tags via treesitter.
vim.pack.add { 'https://github.com/windwp/nvim-ts-autotag' }
require('nvim-ts-autotag').setup {
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false,
  },
}
