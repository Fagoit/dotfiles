# Dotfiles for WindowMaker on Arch Linux

[![Arch Linux](https://img.shields.io/badge/Arch-Linux-1793D1?logo=arch-linux&logoColor=white)](https://archlinux.org/)

Fork of [MacieJonos/dotfiles](https://github.com/MacieJonos/dotfiles) (now archived), converted to a WindowMaker/X11 desktop launched from `ly`.

## Quick Info

- [bin](bin) - scripts used by the WindowMaker session and menus
- [install](install/install) - main installation script
- [pkgs.txt](install/pkgs.txt) - packages installed by the setup
- [setup-by-hardware](install/setup-by-hardware) - laptop/desktop helper package detection and X11 keybinding install
- [setup-config](install/setup-config) - copies `config/` into `~/.config` and installs WindowMaker defaults
- [setup-system](install/setup-system) - system config, `ly`, X session entry, user services, NVIDIA setup, and git setup
- [setup-theme](install/setup-theme) - initial theme and wallpaper symlinks
- [setup-zsh](install/setup-zsh) - zsh config, plugins, and shell helpers

## Features

- WindowMaker desktop with a repo-owned `ly` X session.
- X11 helpers for keybindings, screenshots, wallpaper, locking, notifications, and clipboard.
- Static and dynamic themes with Matugen/Tinte hooks.
- Ghostty, LazyVim, btop, fastfetch, zsh, and utility scripts for development and media work.

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/Fagoit/dotfiles/master/setup.sh | bash
```

This is intended for Arch Linux. The installer backs up changed files first, installs packages from [install/pkgs.txt](install/pkgs.txt), copies configs, installs the `WindowMaker (dotfiles)` X session, and configures `ly` when it is present.

After install, reboot and pick `WindowMaker (dotfiles)` in `ly`.

## Keybinds

Core bindings live in [default/xbindkeys/xbindkeysrc](default/xbindkeys/xbindkeysrc).

- `Super + Q` opens Ghostty.
- `Super + B` opens LibreWolf.
- `Super + E` opens Nautilus.
- `Super + R` opens the app launcher.
- `Super + Alt + Space` opens a run prompt.
- `Super + Shift + S` captures an area to the clipboard.
- `Print` captures an area to a file.

## Theming

- `theme-set <theme>` switches themes.
- `theme-bg-next` cycles wallpapers for the current theme.
- `theme-menu` opens a small Rofi theme picker.
- Dynamic theme exports are handled by Matugen/Tinte and use X11 wallpaper application through `feh`.

## Manual Use

Clone the repository, copy desired files from `config/` to `~/.config`, copy WindowMaker defaults from `default/windowmaker/GNUstep/Defaults` to `~/GNUstep/Defaults`, and start the session with `bin/start-windowmaker`.

## Credits

- <https://github.com/basecamp/omarchy>
- <https://github.com/mylinuxforwork/dotfiles>
- <https://github.com/elifouts/Dotfiles>
