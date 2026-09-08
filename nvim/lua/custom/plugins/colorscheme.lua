-- Personal tokyonight styling (ported from the old config).
-- Runs after SECTION 4, so it overrides kickstart's plain tokyonight-night setup.
vim.pack.add { 'https://github.com/folke/tokyonight.nvim' }

require('tokyonight').setup {
  style = 'night',
  light_style = 'day',
  transparent = true,
  terminal_colors = false,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    sidebars = 'dark',
    floats = 'dark',
  },
  sidebars = { 'qf', 'help' },
  day_brightness = 0.3,
}

vim.cmd.colorscheme 'tokyonight'

-- Keep the real terminal background showing through
for _, group in ipairs { 'Normal', 'NormalNC', 'NonText', 'SignColumn', 'EndOfBuffer' } do
  vim.api.nvim_set_hl(0, group, { bg = 'none', ctermbg = 'none' })
end
