-- windwp/nvim-autopairs. Old config restricted it to web/templating filetypes.
vim.pack.add { 'https://github.com/windwp/nvim-autopairs' }
require('nvim-autopairs').setup {
  filetypes = {
    'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact',
    'svelte', 'vue', 'tsx', 'jsx', 'rescript', 'xml', 'php', 'markdown',
    'astro', 'glimmer', 'handlebars', 'hbs', 'htmldjango',
  },
}
