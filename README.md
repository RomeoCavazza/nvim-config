# Neovim

<p align="left">
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/neovim/neovim-original.svg" alt="Neovim" width="26" />
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/lua/lua-original.svg" alt="Lua" width="26" />
  <img src="https://raw.githubusercontent.com/wiki/RomeoCavazza/nixos-config/images/nixos-config/assets/logo/ollama.png" alt="Ollama" width="26" />
  <a href="https://github.com/RomeoCavazza/nvim-config/actions/workflows/ci.yml"><img src="https://github.com/RomeoCavazza/nvim-config/actions/workflows/ci.yml/badge.svg" alt="CI" /></a>
</p>

This repository contains a Linux/NixOS-oriented Neovim configuration.
`init.lua` is the config entry point.

**This config is only maintained for [the latest nvim stable release](https://github.com/neovim/neovim/releases/tag/stable).**

Requires Neovim 0.10+, Git, a Nerd Font, Ollama for local AI features, and
optionally `fd` plus `ripgrep` for Telescope.

## Visual Guide

<img src="https://raw.githubusercontent.com/wiki/RomeoCavazza/nixos-config/images/nvim-config/assets/␣-bind.webp" width="800" />

<img src="https://raw.githubusercontent.com/wiki/RomeoCavazza/nixos-config/images/nvim-config/assets/!-bind.webp" width="800" />

| Entry | Preview |
|-------|---------|
| **Dashboard** | ![Dashboard](https://raw.githubusercontent.com/wiki/RomeoCavazza/nixos-config/images/nvim-config/assets/hero.webp) |
| **New File** | ![New File](https://raw.githubusercontent.com/wiki/RomeoCavazza/nixos-config/images/nvim-config/assets/new-file.webp) |
| **Open Directory** | ![Open Dir](https://raw.githubusercontent.com/wiki/RomeoCavazza/nixos-config/images/nvim-config/assets/open-dir.webp) |
| **Find File** | ![Find File](https://raw.githubusercontent.com/wiki/RomeoCavazza/nixos-config/images/nvim-config/assets/find-file.webp) |
| **Live Grep** | ![Live Grep](https://raw.githubusercontent.com/wiki/RomeoCavazza/nixos-config/images/nvim-config/assets/live-grep.webp) |
| **Explorer** | ![Explorer](https://raw.githubusercontent.com/wiki/RomeoCavazza/nixos-config/images/nvim-config/assets/explorer.webp) |
| **Open Terminal** | ![Open Terminal](https://raw.githubusercontent.com/wiki/RomeoCavazza/nixos-config/images/nvim-config/assets/terminal.webp) |
| **ShellGeist** | ![ShellGeist](https://raw.githubusercontent.com/wiki/RomeoCavazza/nixos-config/images/nvim-config/assets/shellgeist.webp) |

## Features

- Plugin management through [lazy.nvim](https://github.com/folke/lazy.nvim).
- Dashboard entries for new files, directory opening, file search, live grep,
  explorer, terminal, and ShellGeist.
- Project navigation with [Telescope](https://github.com/nvim-telescope/telescope.nvim)
  and [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua).
- LSP setup through [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
  and [mason.nvim](https://github.com/williamboman/mason.nvim).
- Completion and snippets through [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
  and LuaSnip.
- Diagnostics through [Trouble](https://github.com/folke/trouble.nvim).
- Git workflow through [vim-fugitive](https://github.com/tpope/vim-fugitive)
  and [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim).
- Editing helpers through Flash jumps, Tree-sitter textobjects/textsubjects,
  nvim-surround, Boole toggles, and inline color previews.
- Embedded terminal through [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim).
- UI layer with Tokyo Night, lualine, bufferline, noice, notify, which-key,
  Tree-sitter highlighting, indent guides, and an Edgy side-panel layout.
- Rust support through [rustaceanvim](https://github.com/mrcjkb/rustaceanvim).
- Local AI workflow through CodeCompanion and ShellGeist, with Avante key/window
  hooks kept in the UI layer.

## Key Entries

| Binding | Action |
| --- | --- |
| `SPC e` | Toggle file explorer |
| `SPC t` | Toggle terminal |
| `SPC x` | Toggle diagnostics panel |
| `SPC a` | Toggle Avante when available |
| `SPC h` | Toggle dashboard |
| `SPC c c` | Toggle CodeCompanion chat |
| `SPC c a` | Open CodeCompanion actions or LSP code action |
| `SPC a g` | Open ShellGeist auto mode |
| `SPC a r` | Open ShellGeist review mode |
| `s` | Flash jump |
| `S` | Flash Tree-sitter jump |
| `af` / `if` | Select function outer / inner |
| `ac` / `ic` | Select class outer / inner |
| `aa` / `ia` | Select parameter outer / inner |
| `]f` / `[f` | Next / previous function |
| `]c` / `[c` | Next / previous class |
| `]a` / `[a` | Next / previous parameter |
| `.` / `;` / `i;` | Tree-sitter smart subject selections |
| `SPC +` / `SPC -` | Increment / decrement with Boole |
| `<C-s>` | Save current buffer |
| `<C-q>` | Close current buffer |

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this config
git clone https://github.com/RomeoCavazza/nvim-config ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

## Development

```bash
mapfile -t lua_files < <(find lua -name "*.lua" | sort)
nix shell nixpkgs#lua5_1 -c luac -p init.lua "${lua_files[@]}"
nix shell nixpkgs#stylua -c stylua --check init.lua lua
```

For local AI features:

```bash
# Install Ollama
curl -fsSL https://ollama.ai/install.sh | sh

# Pull recommended models
ollama pull deepseek-coder-v2:16b-lite-instruct-q4_K_M
ollama pull deepseek-r1:14b
```

## Local AI

CodeCompanion is configured to use Ollama locally:

```lua
chat = {
  adapter = "ollama_coder",
}
```

The coding adapter uses:

```text
deepseek-coder-v2:16b-lite-instruct-q4_K_M
```

The reasoning adapter uses:

```text
deepseek-r1:14b
```

ShellGeist is loaded from a local checkout when available and exposes two agent
modes:

- `SPC a g`: auto mode for sidebar + prompt workflows.
- `SPC a r`: review mode for code review style passes.
