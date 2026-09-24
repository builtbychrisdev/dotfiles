# System Setup — Ubuntu 26.04

Reinstall + recovery notes. Config files live in the dotfiles repo; this file
covers everything that *isn't* a file — packages, repos, services, and the
order things have to happen in.

Last updated: 24 Sept 2026

---

## Snapshot

| | |
|---|---|
| OS | Ubuntu 26.04.1 LTS "Resolute Raccoon" |
| Kernel | 7.0.0-generic (HWE series) |
| Session | Wayland |
| Compositor | niri 26.04 (scrollable tiling) |
| Shell/bar | DankMaterialShell (DMS) 1.6.2 + Quickshell 0.3.1 |
| Greeter | greetd + dms-greeter |
| Terminal | Alacritty 0.16.1 |
| Login shell | zsh + starship (gruvbox-rainbow preset) |
| Browser | LibreWolf (via extrepo) — not Firefox |
| Editor | VS Code (+ hand-rolled neovim, unverified on Ubuntu) |
| GPU | RTX 3080 on `nvidia-driver-610-open` 610.57.04 |
| CPU | Ryzen 9 5950X |
| Locale | en_GB.UTF-8 |

Both desktop and laptop run Ubuntu 26.04. 

---

## Fresh install order

Order matters. Doing 6 before 5 gets you a broken login.

### 1. PPAs

```bash
sudo add-apt-repository ppa:avengemedia/danklinux
sudo add-apt-repository ppa:avengemedia/dms
sudo apt update
```

### 2. Packages

```bash
# core
sudo apt install git gh zsh zsh-autosuggestions zsh-syntax-highlighting starship

# desktop
sudo apt install niri dms dms-greeter greetd alacritty adw-gtk3 matugen

# extras
sudo apt install cava khal fprintd qt6-base-dev-tools
```

Note: `gh` from Ubuntu universe is ~2 years stale. If you need current
features, use GitHub's official apt repo instead.

### 3. Fonts

JetBrainsMono Nerd Font → `~/.local/share/fonts`, then:

```bash
fc-cache -f
```

The zip ships **three families** — pick correctly:
- `JetBrainsMono Nerd Font` — general UI
- `JetBrainsMono Nerd Font Mono` — terminals (this is the Alacritty one)
- `JetBrainsMono Nerd Font Propo` — proportional

Quickshell enumerates fonts **at startup**, so after any font change:

```bash
systemctl --user restart dms.service
```

### 4. Dotfiles

```bash
git clone --bare https://github.com/builtbychrisdev/dotfiles.git $HOME/.dotfiles
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dot config --local status.showUntrackedFiles no
```

Git identity — use the GitHub noreply address, **not** the uni email.
The repo is public.

```bash
dot config user.email "ID+builtbychrisdev@users.noreply.github.com"
dot config user.name "builtbychrisdev"
gh auth login
```

### 5. Shell

```bash
chsh -s /usr/bin/zsh
```

Test with plain `zsh` before running this. Escape hatch: `chsh -s /usr/bin/bash`.

Starship preset, if `~/.config/starship.toml` didn't come from the repo:

```bash
starship preset gruvbox-rainbow -o ~/.config/starship.toml
```

### 6. Greeter — do this LAST

```bash
dms-greeter sync
sudo systemctl disable gdm3
sudo systemctl enable greetd
sudo reboot
```

**Do not use `--now` on either systemctl line.** It kills the running session
and drops you back to gdm3.

**Escape hatch if the greeter fails:** `Ctrl+Alt+F3` → TTY login →

```bash
sudo systemctl disable greetd
sudo systemctl enable gdm3
sudo reboot
```

It's `gdm3`, not `gdm`. Wrong name = no display manager at all.

### 7. Theming

DMS handles GTK and Qt — don't install a separate Gruvbox GTK theme.

DMS Settings → **Theme & Colors** → Apply GTK Themes / Apply Qt Themes

VS Code: install `dms-theme.vsix`, select theme **Dynamic Base16 DankShell**.

---

## Config file map

| What | Path | Tracked |
|---|---|---|
| niri | `~/.config/niri/config.kdl` | yes |
| Alacritty | `~/.config/alacritty/alacritty.toml` | yes |
| zsh | `~/.zshrc` | yes |
| starship | `~/.config/starship.toml` | yes |
| DMS settings | `~/.config/DankMaterialShell/settings.json` | yes |
| DMS session state | `~/.local/state/DankMaterialShell/session.json` | no (state) |
| DMS colour cache | `~/.cache/DankMaterialShell/dms-colors.json` | no (generated) |
| greetd | `/etc/greetd/config.toml` | mirror copy only |
| gh token | `~/.config/gh/hosts.yml` | **NEVER** |

greetd sits outside `$HOME` so the bare repo can't reach it. A reference copy
lives at `~/.dotfiles-system/etc/greetd/config.toml` — restoring means
`sudo cp` back by hand, it isn't a live link.

dms-greeter itself needs no backup. `/var/cache/dms-greeter/users/<user>/`
is just symlinks to the DMS files above, rebuilt by `dms-greeter sync`.

---

## Danger zone

1. **Never `dot add ~/.config/gh/`.** The token is plaintext in `hosts.yml`.
2. **Never commit `~/.zsh_history`** or anything under `~/.cache/`.
3. `git add` is all-or-nothing — one missing path aborts the whole command
   and stages nothing.
4. Don't set `DMS_DISABLE_MATUGEN=1`. It kills *all* app theme generation.
   The custom gruvbox DMS theme is what stops wallpaper recolouring.

---

## Keybind trade-offs (Hyprland → niri)

All 17 original Hyprland binds kept their keys. DMS defaults moved:

| Key | Kept for | DMS default moved to |
|---|---|---|
| `Mod+F` | fullscreen | maximize-column → `Mod+Ctrl+F` |
| `Mod+V` | float toggle | clipboard → `Mod+C` |
| `Mod+N` | do-not-disturb | notification centre → `Mod+Shift+N` |
| `Mod+J` | consume-or-expel-right | focus-window-down → arrows |
| `Mod+L` | lock | focus-column-right → arrows |

