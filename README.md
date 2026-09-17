# dotfiles

Arch Linux + Hyprland (Wayland), gruvbox dark hard throughout.
Bare git repo tracking config files directly out of `$HOME`.

## System

| | |
|---|---|
| OS | Arch Linux x86_64 |
| Compositor | Hyprland (Lua config, 0.55+) |
| CPU | AMD Ryzen 9 5950X |
| GPU | NVIDIA RTX 3080 (`nvidia-open-dkms`) |
| Display | DP-1, 2560x1440 @ 144Hz |
| Shell | zsh + starship |
| Terminal | kitty |
| Editor | neovim (hand-rolled, `vim.pack`) |
| Login | greetd + ReGreet on vt1 |
| Theme | Gruvbox Dark Hard / Gruvbox-Plus icons / Bibata-Modern-Amber cursor |
| Font | JetBrainsMono Nerd Font |

## What's in here

```
.zshrc                      shell, aliases, EDITOR
.bashrc .bash_profile       inert, kept for recovery
.config/starship.toml       prompt
.config/hypr/               hyprland.lua, hyprlock, hypridle, hyprpaper, scripts/
.config/waybar/             config.jsonc, style.css
.config/kitty/              kitty.conf
.config/wofi/               config, style.css
.config/mako/               notification daemon
.config/wlogout/            layout, style.css
.config/nvim/               init.lua, lua/, plugin/
.config/fastfetch/          config.jsonc
.config/fontconfig/         fonts.conf
.config/gtk-3.0/            settings.ini
.config/gtk-4.0/            settings.ini
.icons/default/index.theme  cursor theme (Hyprland ignores gsettings)
```

## Restore on a fresh install

```bash
git clone --bare https://github.com/builtbychrisdev/dotfiles.git "$HOME/.dotfiles"
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dot config --local status.showUntrackedFiles no
dot checkout
```

If `dot checkout` refuses because files already exist, move them aside first,
or `dot checkout -f` if you genuinely don't want them.

Then add the alias permanently to `.zshrc`:

```bash
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

## Daily use

```bash
dot add <path>    # new file - required, untracked files are hidden
dot add -u        # all edits to already-tracked files
dot status --short
dot commit -m "msg"
dot push
```

## Packages

```bash
# core
sudo pacman -S --needed hyprland hyprpolkitagent xdg-desktop-portal-hyprland \
  xdg-desktop-portal-gtk kitty wofi mako hyprpaper hyprlock hypridle \
  wl-clipboard grim slurp thunar neovim

# nvidia
sudo pacman -S --needed linux-headers nvidia-open-dkms nvidia-utils egl-wayland

# audio
sudo pacman -S --needed pipewire pipewire-pulse wireplumber

# shell + login
sudo pacman -S --needed zsh zsh-completions zsh-autosuggestions \
  zsh-syntax-highlighting starship greetd greetd-regreet accountsservice plymouth

# fonts
sudo pacman -S --needed ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji \
  noto-fonts-cjk noto-fonts-extra ttf-liberation ttf-dejavu ttf-nerd-fonts-symbols-mono

# tools
sudo pacman -S --needed nwg-look tree-sitter-cli github-cli librewolf fastfetch

# AUR (paru)
paru -S gruvbox-gtk-theme-git gruvbox-plus-icon-theme bibata-cursor-theme-bin \
  wlogout visual-studio-code-bin waybar-git
```

## Keybinds (SUPER = mod)

| Key | Action |
|---|---|
| `SUPER + Return` | kitty |
| `SUPER + B` | browser |
| `SUPER + F` | thunar |
| `SUPER + D` | wofi |
| `SUPER + Q` | close window |
| `SUPER + V` | toggle float |
| `SUPER + SHIFT + F` | fullscreen |
| `SUPER + J` | toggle split |
| `SUPER + 1..5` | switch workspace |
| `SUPER + SHIFT + 1..5` | move window to workspace |
| `SUPER + S` | special workspace |
| `SUPER + W` | random wallpaper |
| `SUPER + L` | lock (hyprlock) |
| `SUPER + N` | mako do-not-disturb |
| `SUPER + SHIFT + M` | exit Hyprland |
| `PRINT` | region screenshot to clipboard |

## Gotchas (learned the hard way)

- **Hyprland config is Lua.** hyprlang `.conf` has been deprecated since 0.55.
  Hyprland only loads the Lua provider if the filename ends in `.lua`.
- **hyprlock, hypridle and hyprpaper are still hyprlang `.conf`.** Only
  `hyprland.lua` is Lua. Commands inside them use the Lua dispatcher form.
- **`misc:vfr` moved to `debug:vfr` in 0.55** and is on by default. Don't set it.
- **hyprpaper dropped `preload =`.** Use `wallpaper { monitor / path / fit_mode }`
  blocks or every line errors as "Invalid config line".
- **waybar must come from AUR `waybar-git`.** Extra's 0.15.0 sends pre-Lua
  dispatch syntax, so workspace buttons do nothing (Alexays/Waybar#5008).
- **Never declare persistent workspaces in both waybar and `hyprland.lua`** —
  the buttons vanish entirely (Alexays/Waybar#2945).
- **No modulo in the workspace bind loop** with 5 workspaces. `i % 5` maps
  workspace 5 onto key 0.
- **`hyprctl keyword` doesn't work with a Lua config.** Use
  `hyprctl eval 'hl.config({ ... })'`.
- **Cursor theme:** `gsettings` silently does nothing on Hyprland. Needs
  `~/.icons/default/index.theme` plus `hyprctl setcursor <theme> 24`.
- **Hibernation needs no mkinitcpio changes** on a systemd initramfs — no
  `resume` hook, no `resume=` kernel parameter. Just enable the three
  `nvidia-{suspend,hibernate,resume}.service` units.
- **fontconfig:** `50-user.conf` must be linked into `/etc/fonts/conf.d/` or
  `~/.config/fontconfig/` is ignored outright.
- **Steam:** pick `lib32-nvidia-utils` at the 32-bit Vulkan driver prompt.
- **`pacman -S` is all-or-nothing.** One bad package name aborts everything,
  which looks identical to "command not found" afterwards.

## Not tracked here

System files, copy them manually:

```
/etc/greetd/{config.toml,hyprland.lua,regreet.toml}
/etc/pam.d/greetd
/etc/mkinitcpio.conf
/etc/default/grub
/etc/pacman.conf
```

**Never commit `~/.config/gh/hosts.yml`** — github-cli stores the OAuth token
there in plain text.
