-- Ahoorast/Comrade (dev branch) -- Neovim <-> JetBrains bridge. Remote plugin,
-- needs the python3 provider (pynvim). We only load it once that's available so
-- a machine without pynvim doesn't get the startup error.
--
-- To enable the provider:
--   Fedora:    sudo dnf install python3-neovim
--   userspace: python3 -m ensurepip && python3 -m pip install --user pynvim
-- then in nvim: :UpdateRemotePlugins  and restart.
--
-- Set this to true to load Comrade regardless (or just delete the guard).
local force = false

if force or vim.fn.has 'python3' == 1 then
  vim.pack.add {
    { src = 'https://github.com/Ahoorast/Comrade', version = 'dev' },
  }
else
  vim.notify_once('Comrade skipped: no python3 provider (see lua/custom/plugins/comrade.lua)', vim.log.levels.WARN)
end
