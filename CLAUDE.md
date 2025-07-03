# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository containing configuration files for various development tools and applications. The primary focus is on Neovim configuration with custom plugins and settings.

## Repository Structure

The repository is organized as follows:

- `nvim/` - Neovim configuration based on kickstart.nvim
  - `lua/03_22_25/` - Current active configuration directory
    - `config/` - Core configuration files (options, mappings, autocommands)
    - `plugins/` - Plugin configurations using lazy.nvim
    - `components/` - Custom components and utilities
  - `lua/custom/` - Alternative/backup configuration
  - `lua/kickstart/` - Base kickstart.nvim files
- `raycast/` - Raycast extensions and configurations
- Various dotfiles (`.gitignore_global`, `.zsh_profile`, etc.)

## Neovim Configuration Architecture

The Neovim setup uses a modular architecture with lazy.nvim as the plugin manager:

1. **Entry Point**: `init.lua` loads the main configuration from `03_22_25/`
2. **Core Setup**: `lua/03_22_25/init.lua` sets up lazy.nvim and loads plugins
3. **Plugin Management**: All plugins are configured in `lua/03_22_25/plugins/` with individual files per plugin/feature
4. **Configuration**: Base vim options, mappings, and autocommands are in `lua/03_22_25/config/`

## Key Plugin Categories

- **LSP & Development**: `lsp.lua`, `code_companion.lua`, `copilot.lua`
- **UI/UX**: `appearance.lua`, `lualine.lua`, `telescope.lua`
- **Git Integration**: `git.lua`, `lazygit.lua` (in custom/)
- **Code Quality**: `lint.lua`, `conform.lua`, `treesitter.lua`
- **Navigation**: `harpoon.lua`, `telescope.lua`, `whichkey.lua`
- **Terminal**: `fterm.lua`

## Development Workflow

- Configuration follows the kickstart.nvim pattern but is heavily customized
- The `03_22_25/` directory represents the active configuration snapshot
- Plugin configurations are self-contained in individual files
- Custom components like `code_companion_lualine.lua` extend base functionality

## Important Notes

- This is a personal configuration repository, not a shared development project
- No build/test commands are present as this is primarily configuration files
- The configuration is designed for macOS development environment
- Neovim plugins are managed through lazy.nvim with lazy-lock.json for reproducible installs