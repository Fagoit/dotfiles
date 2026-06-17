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
- [setup-theme](install/setup-theme) - theme and wallpaper symlinks
- [setup-zsh](install/setup-zsh) - zsh config, plugins, and shell helpers

## Features

- WindowMaker desktop with a repo-owned `ly` X session.
- X11 helpers for keybindings, screenshots, wallpaper, locking, notifications, and clipboard.
- A single purple WindowMaker theme applied across Ghostty, btop, dunst, GTK, and Neovim.
- Ghostty, LazyVim, btop, fastfetch, zsh, and utility scripts for development and media work.

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/Fagoit/dotfiles/windowmaker/setup.sh | bash
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

Window management is handled by WindowMaker (see [default/windowmaker/GNUstep/Defaults/WindowMaker](default/windowmaker/GNUstep/Defaults/WindowMaker)):

- `Super + W` closes the focused window.
- `Super + Up` maximizes; `Super + N` miniaturizes; `Super + M` move/resize.
- `Super + Tab` / `Super + Shift + Tab` cycle windows.
- `Super + 1..4` switch workspaces; `Super + Shift + 1..4` move the window to a workspace.
- Right-click the desktop for the application menu.

## Monitors

Monitors are configured at login by [bin/x-monitors](bin/x-monitors), which
arranges all connected outputs left-to-right at their preferred resolution and
highest refresh rate (first output set as primary). For a custom layout, create
`~/.config/dotfiles/monitors.sh` with raw `xrandr` commands; it is used verbatim
when present. Run `xrandr --query` to discover output names and modes.

## Theming

The WindowMaker theme itself is a fixed purple set (`default/windowmaker`), but
app accent colors (rofi, dunst, picom shadow glow) are driven dynamically by
[pywal](https://github.com/eylles/pywal16). `bin/x-wallpaper` samples the current
wallpaper (a frame of the video, or the image itself), runs `wal`, and `bin/walrefresh`
wires the generated palette into rofi (`colors.rasi`), dunst, and picom (`shadow.conf`).
Static purple fallbacks ship in `config/rofi/colors.rasi` and `config/picom/shadow.conf`
for a fresh install before any palette has been generated. Wallpaper (static image or
animated video) is applied from `current/background`.

## Manual Use

Clone the repository, copy desired files from `config/` to `~/.config`, copy WindowMaker defaults from `default/windowmaker/GNUstep/Defaults` to `~/GNUstep/Defaults`, and start the session with `bin/start-windowmaker`.

## Credits

- <https://github.com/basecamp/omarchy>
- <https://github.com/mylinuxforwork/dotfiles>
- <https://github.com/elifouts/Dotfiles>
