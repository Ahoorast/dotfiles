-- ============================================================
-- Personal keymaps -- SOURCE OF TRUTH
-- Ported verbatim (in behavior) from the old lazy.nvim init.lua.
-- Loaded at the end of SECTION 2 in init.lua, so anything set here
-- wins over kickstart's global defaults. Plugin requires are deferred
-- (wrapped in functions / <cmd>) because plugins load later, in SECTION 10.
-- ============================================================

local map = vim.keymap.set

-- <Space> as a no-op so it only ever acts as <leader>
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- ii -> <Esc> in insert mode
map('i', 'ii', '<Esc>', { silent = true })

-- Edit the alternate (previous) file
map('n', '<leader>pv', '<cmd>edit #<CR>', { silent = true, desc = 'Edit alternate file' })

-- File explorer (oil.nvim)
map('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' })

-- Move visually selected lines up/down, keeping selection
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Word-wrap aware j/k
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Yank to the system clipboard
map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map('n', '<leader>Y', [["+Y]], { desc = 'Yank line to system clipboard' })

-- Format (conform). <leader>f is also provided by kickstart's SECTION 7.
map({ 'n', 'v' }, 'ff', function() require('conform').format { async = true, lsp_format = 'fallback' } end, { desc = 'Format buffer/range' })

-- Diagnostics
map('n', '[d', function() vim.diagnostic.jump { count = -1, float = true } end, { desc = 'Previous diagnostic' })
map('n', ']d', function() vim.diagnostic.jump { count = 1, float = true } end, { desc = 'Next diagnostic' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic loclist' })

-- Undotree
map('n', '<leader>u', '<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>', { desc = 'Toggle undotree' })

-- Harpoon
map('n', '<leader>ha', function() require('harpoon'):list():add() end, { desc = 'Harpoon add file' })
map('n', '<leader>hr', function()
  local harpoon = require 'harpoon'
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon quick menu' })

-- Telescope pickers that the old config had but kickstart doesn't
map('n', '<leader>?', function() require('telescope.builtin').oldfiles() end, { desc = '[?] Recently opened files' })
map('n', '<leader><space>', function() require('telescope.builtin').buffers() end, { desc = '[ ] Find buffers' })
map('n', '<leader>gf', function() require('telescope.builtin').git_files() end, { desc = 'Search [G]it [F]iles' })

-- Create a new file next to the current buffer
map('n', '<leader>nf', function()
  local current_dir = vim.fn.expand '%:p:h'
  local new_file = vim.fn.input('New File: ' .. current_dir .. '/')
  if new_file == '' then
    return
  end
  if vim.fn.filereadable(current_dir .. '/' .. new_file) == 1 then
    print 'File already exists'
    return
  end
  vim.cmd('edit %:p:h/' .. new_file)
end, { desc = 'New file in current dir' })

-- Create a new folder next to the current buffer
map('n', '<leader>nd', function()
  local current_dir = vim.fn.expand '%:p:h'
  local new_folder = vim.fn.input('New Folder: ' .. current_dir .. '/')
  if new_folder == '' then
    return
  end
  local path = current_dir .. '/' .. new_folder
  if vim.fn.isdirectory(path) == 1 then
    print 'Folder already exists'
    return
  end
  vim.fn.mkdir(path, 'p')
end, { desc = 'New folder in current dir' })

-- Debug helpers
map('n', '<leader>lsa', function()
  local names = vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients())
  print(('%d attached: %s'):format(#names, table.concat(names, ', ')))
end, { desc = 'List active LSP clients' })

map('n', '<leader>tsa', function()
  print(vim.inspect(require('nvim-treesitter').get_installed 'parsers'))
end, { desc = 'List installed treesitter parsers' })

-- Copilot (github/copilot.vim is not installed -- see lua/custom/plugins/copilot.lua)
-- vim.cmd [[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]]
-- vim.cmd [[highlight CopilotSuggestion guifg=#555555 ctermfg=8]]

-- ============================================================
-- Buffer-local LSP keymaps (old config's on_attach scheme).
-- These deliberately shadow kickstart's `gr*` chords; the
-- equivalents live on <leader>rn / <leader>ca / gd / gI / <leader>D.
-- ============================================================
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('custom-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf
    local tb = require 'telescope.builtin'
    local function bmap(keys, fn, desc)
      map('n', keys, fn, { buffer = buf, desc = 'LSP: ' .. desc })
    end

    bmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    bmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    bmap('gd', tb.lsp_definitions, '[G]oto [D]efinition')
    bmap('gr', tb.lsp_references, '[G]oto [R]eferences')
    bmap('gI', tb.lsp_implementations, '[G]oto [I]mplementation')
    bmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    bmap('<leader>D', tb.lsp_type_definitions, 'Type [D]efinition')
    bmap('<leader>ds', tb.lsp_document_symbols, '[D]ocument [S]ymbols')
    bmap('<leader>ws', tb.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    bmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    bmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    bmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    bmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    vim.api.nvim_buf_create_user_command(buf, 'Format', function()
      require('conform').format { bufnr = buf, async = true, lsp_format = 'fallback' }
    end, { desc = 'Format current buffer' })

    -- NOTE: old config bound <C-k> to signature_help. Kept as window-nav
    -- instead; blink.cmp shows the signature window automatically while typing.
  end,
})
