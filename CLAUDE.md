# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a LazyVim-based Neovim configuration with extensive customizations. It includes AI integration (Claude Code), enhanced editor features, language support for multiple programming languages, and custom keymaps with Emacs-style bindings.

## Key Architecture

### Plugin Management

- Uses `lazy.nvim` as the plugin manager (lua/config/lazy.lua:10)
- LazyVim provides the base configuration with extras loaded via lazyvim.json:2-36
- Custom plugins are organized in lua/plugins/ directory with language-specific plugins in lua/plugins/lang/

### Configuration Structure

- `init.lua` bootstraps the configuration by requiring config.lazy
- `lua/config/` contains core configuration files:
  - `options.lua` - Neovim options and settings
  - `keymaps.lua` - Custom key mappings and Emacs emulation
  - `emacs.lua` - Emacs-style navigation and editing bindings
  - `autocmds.lua` - Auto commands
- `lua/plugins/` contains plugin specifications organized by category
- `lua/helpers.lua` provides utility functions for mappings and clipboard operations

### Language Support

Configured languages include (from lazyvim.json):

- Go, Rust, Python, TypeScript/JavaScript
- Docker, JSON, YAML, TOML, SQL, Markdown
- C/C++ (clangd), Git integration

### Key Features

- **AI Integration**: Claude Code plugin with extensive keymaps (lua/plugins/ai.lua:8-24)
- **Emacs Bindings**: Full Emacs-style navigation in insert/command mode (lua/config/emacs.lua)
- **Custom Options**: Disabled swap files, enabled spell check, rounded borders (lua/config/options.lua:6-34)
- **Enhanced Editor**: Aerial (code outline), mini.files (file explorer), todo-comments

## Common Development Commands

### Code Formatting

- Uses stylua for Lua formatting with 2-space indentation (stylua.toml:1-3)
- Language-specific formatters configured via LazyVim extras (black for Python, biome for JS/TS)

### LSP Configuration

- Configured via neoconf.json with language-specific settings:
  - lua_ls with completion snippets (neoconf.json:19-21)
  - gopls with placeholders and hints (neoconf.json:22-32)
  - vtsls with non-relative imports and code lens (neoconf.json:33-42)

### Key Mappings

- Leader key mappings for AI: `<leader>a*` (Claude Code integration)
- Clipboard operations: `<leader>y*` (copy file paths, content)
- Save with formatting: `<C-s>`, save without: `<C-S-s>` or `<leader>W`
- Git operations: `<leader>gw` (whatchanged), `<leader>gD` (diff)
- Emacs-style navigation: `<C-a>` (home), `<C-e>` (end), `<C-f>/<C-b>` (char movement)

### Plugin Architecture

- Core plugins managed by LazyVim base configuration
- Custom overrides and additions in lua/plugins/*.lua files
- Language-specific plugins in lua/plugins/lang/ subdirectory
- Helper functions centralized in lua/helpers.lua for consistent API

### Special Configurations

- Global border style set to "rounded" (lua/config/options.lua:6)
- Disabled autoformat by default (lua/config/options.lua:9)
- Local leader set to comma (lua/config/options.lua:10)
- Spell checking enabled with camelCase support (lua/config/options.lua:25-28)

