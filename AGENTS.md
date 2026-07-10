# AGENTS.md

This is a LazyVim-based Neovim configuration. There is no build, test, or lint step — changes take effect on next Neovim launch.

## Plugin structure

- `lua/plugins/*.lua` — custom plugin specs, auto-imported by `lua/config/lazy.lua:14`
- `lua/plugins/lang/*.lua` — language-specific plugin specs, auto-imported by `lua/config/lazy.lua:15`
- `lazyvim.json` — LazyVim extras that pull in upstream plugin specs automatically
- `lazy-lock.json` — auto-generated snapshot; do **not** edit manually

## Shared utilities

`lua/helpers.lua` provides module-level functions used throughout:
- `helpers.map(mode, lhs, rhs, opts)` — keymap wrapper
- `helpers.augroup(name)` — create an autocmd group with `clear = true`
- `helpers.copy(text)` — copy to system clipboard
- `helpers.statuscolumn()` — statuscolumn rendering (hides on dashboard/special buffers)
- `helpers.setup_ghostty()` — Ghostty terminal title integration

## Code conventions

- Lua formatting: `stylua.toml` (2-space indent, 120 col width)
- Minimal comments — the existing code avoids doc blocks and explanatory comments
- Plugin specs return a table `{ "author/plugin", opts = {...} }` (lazy.nvim format, no return needed inside `spec` imports)
- Globals declared in `.luarc.json`: `Difft`, `Snacks`, `LazyVim`

## LSP config

`neoconf.json` configures language servers: `lua_ls` (callSnippet=Replace), `gopls` (placeholders+hints, fieldalignment=off), `vtsls` (non-relative imports, code lens on)

## Verified context (not obvious from filenames)

- `vim.g.autoformat = false` — autoformat is **off** by default (`lua/config/options.lua:8`)
- `vim.g.root_spec = { "cwd" }` — root dir is always cwd, not git root (`lua/config/options.lua:11`)
- `vim.g.lazyvim_python_lsp = "basedpyright"` — overrides LazyVim's default pyright
- Emacs-style keymaps apply in insert mode via mode label `"!"` (see `lua/config/emacs.lua:36`)
- Ghostty terminal title is set on startup (`lua/config/lazy.lua:47`)
- On start with no args, Snacks explorer opens automatically (`lua/config/autocmds.lua:75`)
- Copilot is detached from files under the LeetCode data directory (`lua/config/autocmds.lua:20`)
