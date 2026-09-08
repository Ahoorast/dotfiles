-- ============================================================
-- Personal options (ported from the old lazy.nvim config)
-- Loaded at the end of SECTION 1 in init.lua.
-- These intentionally override kickstart defaults.
-- ============================================================

-- Old config disabled search highlight entirely
vim.o.hlsearch = false

-- Relative line numbers (kickstart leaves this off)
vim.o.relativenumber = true

-- Keep the cursor vertically centered
vim.o.scrolloff = 999

-- Spell checking on by default (uses spell/en.utf-8.add in this repo)
vim.o.spell = true
vim.o.spelllang = 'en'

-- Indentation: hard 4-space, expand tabs (old config set this everywhere)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Persistent undo in a dedicated dir; no swap/backup files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand '~/.vim/undodir'
vim.fn.mkdir(vim.opt.undodir:get()[1], 'p')

-- Farsi / bidirectional text support
vim.opt.termbidi = true

-- Old config kept the OS clipboard independent (kickstart syncs it).
-- Uncomment to restore that behavior:
-- vim.o.clipboard = ''
