-- themaxmarchuk/tailwindcss-colors.nvim -- show color swatches for Tailwind classes.
vim.pack.add { 'https://github.com/themaxmarchuk/tailwindcss-colors.nvim' }
require('tailwindcss-colors').setup()

-- Attach it to any buffer where the tailwindcss language server comes up.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('custom-tailwind-colors', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.name == 'tailwindcss' then
      require('tailwindcss-colors').buf_attach(event.buf)
    end
  end,
})
