# Local customizations

This is upstream [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
(the `vim.pack` generation) with personal changes layered on top of the old
lazy.nvim config.

## Where things live

| File | Purpose |
| --- | --- |
| `init.lua` | Upstream, plus ~11 small edits each tagged `-- CUSTOM` |
| `lua/custom/options.lua` | Personal option overrides (loaded at end of SECTION 1) |
| `lua/custom/keymaps.lua` | **Personal keymaps — source of truth** (loaded at end of SECTION 2) + buffer-local LSP maps |
| `lua/custom/plugins/*.lua` | One file per extra plugin, auto-loaded from SECTION 10 |
| `spell/` | Personal spell dictionary (`vim.o.spell = true`) |

## Extra plugins (`lua/custom/plugins/`)

harpoon2, oil.nvim, undotree, vim-fugitive + vim-rhubarb, nvim-autopairs
(web filetypes only), nvim-ts-autotag, tailwindcss-colors, Comrade (dev),
django-plus.vim, tokyonight styling override (`colorscheme.lua`),
copilot.vim (disabled).

## Deliberate changes vs. the old config

- **Completion**: `deoplete` + `nvim-cmp` → `blink.cmp` (upstream). `<C-y>` still accepts.
- **`tsserver` → `ts_ls`** (renamed upstream).
- **`vuels`** was removed upstream; `vue_ls` is stubbed out in the `servers` table — enable if needed.
- **`<leader>hr`** is harpoon (old config). Gitsigns' reset-hunk moved to **`<leader>hu`**.
- **`<C-k>`** stays window-nav (was signature-help in the old config); blink shows
  the signature window automatically.
- Bare `gr` / `gd` / `gI` / `gD` / `K` LSP maps (old scheme) shadow kickstart's
  `gr*` chords. Equivalents: `<leader>rn`, `<leader>ca`, `gd`, `gI`, `<leader>D`.
- Statusline is `mini.statusline` (upstream), not `lualine`.
- `Comment.nvim` dropped — Neovim's built-in `gc` / `gcc` covers it.

## First run

Open `nvim` once with a network connection. `vim.pack` clones every plugin and
`:Mason` installs the LSP servers + `prettierd`/`prettier`/`stylua`. Treesitter
parsers install on first use of each filetype.

If a plugin download fails midway, re-open nvim or run `:lua vim.pack.update()`.

## Re-syncing with upstream later

```sh
cd /tmp && git clone https://github.com/nvim-lua/kickstart.nvim
# diff their init.lua against ours; re-apply anything interesting.
# Our changes are all marked `-- CUSTOM`, so `git diff` stays readable.
diff -u kickstart.nvim/init.lua ~/Projects/dotfiles/nvim/init.lua
```

`:Mason`, `:checkhealth`, and `:checkhealth vim.provider` (Comrade needs the
`python3` provider: `pip install --user pynvim`).
