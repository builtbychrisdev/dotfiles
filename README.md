# My .dotfiles — Ubuntu 26.04

Reinstall and recovery notes for my desktop and laptop. Config files live in
the dotfiles repo; this file covers everything that isn't a file — repos,
packages, services, and the order things have to happen in.

Last updated: 24 Sept 2026

---

## Snapshot

| | |
|---|---|
| OS | Ubuntu 26.04.1 LTS "Resolute Raccoon" |
| Kernel | 7.0.0-generic (HWE series) |
| Session | Wayland |
| Compositor | niri 26.04 (scrollable tiling) |
| Shell / bar | DankMaterialShell (DMS) 1.6.2 + Quickshell 0.3.1 |
| Greeter | greetd + dms-greeter |
| Terminal | Alacritty 0.16.1 |
| Login shell | zsh + starship (gruvbox-rainbow preset) |
| Browser | LibreWolf |
| Editors | VS Code, neovim (hand-rolled config) |
| GPU | RTX 3080, `nvidia-driver-610-open` 610.57.04 |
| CPU | Ryzen 9 5950X |
| Locale | en_GB.UTF-8 |

---

## Fresh install

Work top to bottom. The one hard ordering rule is that **the greeter goes
last** — `dms-greeter sync` copies your DMS theme and settings into the login
screen, so DMS has to be installed and configured before it runs.

### 1. Repositories

DMS and niri:

```bash
sudo add-apt-repository ppa:avengemedia/danklinux
sudo add-apt-repository ppa:avengemedia/dms
```

LibreWolf:

```bash
sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo extrepo update librewolf
```

VS Code:

```bash
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
  | sudo gpg --dearmor -o /usr/share/keyrings/microsoft.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
  | sudo tee /etc/apt/sources.list.d/vscode.list
```

Then:

```bash
sudo apt update
```

### 2. Packages

```bash
# shell and tooling
sudo apt install git gh zsh zsh-autosuggestions zsh-syntax-highlighting starship

# desktop
sudo apt install niri dms dms-greeter greetd alacritty adw-gtk3 matugen

# utilities the niri config depends on
sudo apt install cliphist wl-clipboard nautilus

# apps
sudo apt install librewolf code

# optional extras
sudo apt install cava khal fprintd qt6-base-dev-tools
```

`cliphist` and `wl-clipboard` are not optional — the niri config has a
`spawn-at-startup` entry for the clipboard watcher, and without them the
clipboard history keybind silently does nothing.

`gh` from Ubuntu universe lags well behind upstream. If you need recent
features, use GitHub's own apt repository instead.

### 3. Fonts

Install JetBrainsMono Nerd Font into `~/.local/share/fonts`, then:

```bash
fc-cache -f
```

The archive contains three families — pick the right one:

- `JetBrainsMono Nerd Font` — general UI
- `JetBrainsMono Nerd Font Mono` — terminals, this is the Alacritty one
- `JetBrainsMono Nerd Font Propo` — proportional

Quickshell reads the font list once at startup, so after any font change:

```bash
systemctl --user restart dms.service
```

### 4. Dotfiles

Bare repo with `$HOME` as the work tree.

```bash
git clone --bare https://github.com/builtbychrisdev/dotfiles.git $HOME/.dotfiles
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dot checkout
dot config --local status.showUntrackedFiles no
```

**`dot checkout` overwrites files in `$HOME`.** That is what you want on a
fresh install and what you do not want on a machine already set up. If it
refuses because files are in the way, git prints the list — move those
somewhere safe and run it again.

The `dot` alias above only lasts for the current terminal. The permanent one
lives in `.zshrc`, which arrives with the checkout.

Set the commit identity. This repo is public, so use the GitHub-provided
noreply address, which you can find at **github.com/settings/emails**:

```bash
dot config user.email "<your-noreply-address>"
dot config user.name "builtbychrisdev"
gh auth login
```

### 5. Shell

Test it before committing to it:

```bash
zsh
```

If the prompt renders and autosuggestions work, make it permanent:

```bash
chsh -s /usr/bin/zsh
```

Log out and back in. To undo: `chsh -s /usr/bin/bash`.

If `~/.config/starship.toml` didn't come from the repo:

```bash
starship preset gruvbox-rainbow -o ~/.config/starship.toml
```

### 6. Theming

DMS generates the GTK and Qt themes. Don't install a separate GTK theme and
don't set `DMS_DISABLE_MATUGEN=1` — that switches off theme generation
entirely.

DMS Settings → **Theme & Colors** → Apply GTK Themes / Apply Qt Themes

VS Code: install `dms-theme.vsix` and select the **Dynamic Base16 DankShell**
theme.

### 7. Greeter

Do this after everything above.

```bash
dms-greeter sync
sudo systemctl disable gdm3
sudo systemctl enable greetd
sudo reboot
```

**Do not add `--now` to either systemctl line.** It acts on the running
session and drops you back to gdm3.

If the greeter fails and you can't log in, switch to a TTY with
`Ctrl+Alt+F3` and reverse it:

```bash
sudo systemctl disable greetd
sudo systemctl enable gdm3
sudo reboot
```

The service is `gdm3`, not `gdm`. The wrong name leaves you with no display
manager at all.

---

## Config file map

| What | Path | In the repo |
|---|---|---|
| niri | `~/.config/niri/config.kdl` | yes |
| Alacritty | `~/.config/alacritty/alacritty.toml` | yes |
| zsh | `~/.zshrc` | yes |
| starship | `~/.config/starship.toml` | yes |
| DMS settings | `~/.config/DankMaterialShell/settings.json` | yes |
| DMS session state | `~/.local/state/DankMaterialShell/session.json` | no, machine state |
| DMS colour cache | `~/.cache/DankMaterialShell/dms-colors.json` | no, generated |
| greetd | `/etc/greetd/config.toml` | reference copy only |

Credentials, shell history and anything under `~/.cache/` are never tracked.

greetd lives outside `$HOME`, so the bare repo can't reach it. A copy is kept
at `~/.dotfiles-system/etc/greetd/config.toml` for reference — restoring it
means copying it back by hand, it isn't a live link.

dms-greeter needs no backup of its own. Its per-user directory under
`/var/cache/dms-greeter/` is symlinks to the DMS files above, rebuilt by
`dms-greeter sync`.

---

## Keybinds

`Mod` is Super.

| Key | Action |
|---|---|
| `Mod+Return` | Alacritty |
| `Mod+B` | LibreWolf |
| `Mod+F` | Files |
| `Mod+D` | App launcher |
| `Mod+Q` | Close window |
| `Mod+V` | Toggle floating |
| `Mod+Shift+F` | Fullscreen |
| `Mod+S` | Floating ↔ tiling |
| `Mod+J` | Consume or expel right |
| `Mod+W` | Next wallpaper |
| `Mod+L` | Lock |
| `Mod+N` | Do not disturb |
| `Mod+C` | Clipboard history |
| `Mod+X` | Control centre |
| `Mod+Tab` | Overview |
| `Mod+Escape` | Power menu |
| `Mod+Shift+N` | Notification centre |
| `Mod+Ctrl+F` | Maximise column |
| `Mod+Ctrl+C` | Centre column |
| `Mod+R` / `Mod+Shift+R` | Cycle column width / window height |
| `Mod+Minus` / `Mod+Equal` | Resize column |
| `Mod+Shift+M` | Quit niri |
| Arrow keys | Focus and move, with `Shift` and `Ctrl` |
| `Mod+1`–`9` | Switch workspace |
| `Mod+Shift+1`–`9` | Move window to workspace |
| `Print` | Screenshot |

`Mod+C`, `Mod+Shift+N` and `Mod+Ctrl+F` are DMS defaults that were moved,
because `Mod+V`, `Mod+N` and `Mod+F` are used above.

