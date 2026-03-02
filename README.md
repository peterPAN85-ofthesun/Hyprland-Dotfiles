# Dotfiles — Hyprland Configuration

Personal Hyprland configuration based on **[end-4/dots-hyprland](https://github.com/end-4/dots-hyprland)**.
Most of the base configuration (quickshell, hyprland, window rules, scripts…)
comes from that project. This repo contains only my customizations on top of it.

## Software included

| Software | Role |
|---|---|
| [Hyprland](https://hyprland.org) | Wayland compositor |
| [Hyprlock](https://github.com/hyprwm/hyprlock) | Lock screen |
| [Hypridle](https://github.com/hyprwm/hypridle) | Idle management |
| [Quickshell](https://quickshell.outfoxxed.me/) (illogical-impulse) | Bar / widgets / shell |
| [Kitty](https://sw.kovidgoyal.net/kitty/) | Primary terminal |
| [Foot](https://codeberg.org/dnkl/foot) | Secondary terminal |
| [Fuzzel](https://codeberg.org/dnkl/fuzzel) | App launcher |
| [Wlogout](https://github.com/ArtsyMacaw/wlogout) | Session menu |
| [Cava](https://github.com/karlstav/cava) | Audio visualizer |
| [Matugen](https://github.com/InioX/matugen) | Material You theme generation |
| [Fish](https://fishshell.com/) | Shell |
| [Starship](https://starship.rs/) | Prompt |
| [MPV](https://mpv.io/) | Media player |

## Keybindings

> **Super** = Windows key.
> **AZERTY** layout — some bindings have been adapted (see Custom section).

### Shell & Interface

| Shortcut | Action |
|---|---|
| `Super` | Search / Launcher |
| `Super + Tab` | Workspace overview |
| `Super + A` | Left sidebar |
| `Super + N` | Right sidebar |
| `Super + H` | Cheatsheet (keybind help) |
| `Super + J` | Toggle bar |
| `Super + M` | Media controls |
| `Super + G` | Overlay |
| `Super + K` | On-screen keyboard |
| `Super + V` | Clipboard history |
| `Super + .` | Emoji picker |
| `Ctrl+Super + R` | Restart widgets |
| `Ctrl+Super + P` | Cycle panel family |
| `Ctrl+Alt + Del` | Session menu |

### Screenshots & Recording

| Shortcut | Action |
|---|---|
| `Print` | Fullscreen screenshot → clipboard |
| `Ctrl + Print` | Screenshot → clipboard & file |
| `Super+Shift + S` | Region screenshot → clipboard |
| `Super+Shift + A` | Region screenshot → Google Lens |
| `Super+Shift + X` | OCR region → clipboard |
| `Super+Shift + C` | Color picker (Hex) → clipboard |
| `Super+Shift + R` | Record region (no audio) |
| `Ctrl+Alt + R` | Record screen (no audio) |
| `Super+Shift+Alt + R` | Record screen (with audio) |
| `Ctrl+Super + T` | Wallpaper selector |
| `Ctrl+Super+Alt + T` | Random wallpaper |

### Brightness & Volume

| Shortcut | Action |
|---|---|
| `🔆 / 🔅` (fn keys) | Brightness + / - |
| `🔊 / 🔉` (fn keys) | Volume + / - |
| `🔇` (fn key) | Mute audio output |
| `Super+Shift + M` | Mute audio output |
| `Alt + 🔇` / `Super+Alt + M` | Mute microphone |

### Windows

| Shortcut | Action |
|---|---|
| `Super + ←/↑/→/↓` | Focus in direction |
| `Super+Shift + ←/↑/→/↓` | Move window |
| `Super + left click` (drag) | Move window |
| `Super + right click` (drag) | Resize window |
| `Super + Q` / `Alt + F4` | Close window |
| `Super+Shift+Alt + Q` | Force kill window |
| `Super+Alt + Space` | Toggle floating / tiled |
| `Super + D` | Maximize |
| `Super + F` | Fullscreen |
| `Super+Alt + F` | Fullscreen spoof |
| `Super + P` | Pin window |
| `Super+Ctrl + ,` | Decrease split ratio *(AZERTY)* |
| `Super+Ctrl + .` | Increase split ratio *(AZERTY)* |
| `Ctrl+Super + \` | Force window size to 640×480 |

### Workspaces

| Shortcut | Action |
|---|---|
| `Super + 1…0` | Go to workspace 1–10 |
| `Super+Alt + 1…0` | Send window to workspace 1–10 |
| `Ctrl+Super + ←/→` | Previous / next workspace |
| `Super + PageUp/Down` | Previous / next workspace |
| `Super + S` | Toggle scratchpad |
| `Super+Alt + S` | Send to scratchpad |

### Session

| Shortcut | Action |
|---|---|
| `Super + L` | Lock screen |
| `Super+Shift + L` | Suspend |
| `Ctrl+Shift+Alt+Super + Del` | Shutdown |

### Screen Zoom

| Shortcut | Action |
|---|---|
| `Super + -` | Zoom out |
| `Super + =` | Zoom in |

### Media

| Shortcut | Action |
|---|---|
| `Super+Shift + P` | Play / Pause |
| `Super+Shift + N` | Next track |
| `Super+Shift + B` | Previous track |
| Media keys (fn) | Play / Pause / Next / Previous |

### Applications

| Shortcut | Action |
|---|---|
| `Super + Enter` | Terminal (kitty) |
| `Super + E` | File manager (dolphin) |
| `Super + W` | Web browser |
| `Super + C` | Neovim (in kitty) |
| `Super + X` | Obsidian |
| `Ctrl+Super + V` | Volume mixer (pavucontrol-qt) |
| `Super + I` | Settings |
| `Ctrl+Shift + Esc` | Task manager |

---

## Dependencies

### pacman packages

```bash
sudo pacman -S \
  hyprland hyprlock hypridle hyprpicker \
  kitty foot fuzzel wlogout cava \
  fish starship mpv \
  wireplumber playerctl \
  grim slurp wl-clipboard \
  brightnessctl \
  gnome-keyring libsecret \
  cliphist \
  dbus \
  geoclue \
  eza
```

### AUR packages

```bash
yay -S \
  quickshell-git \
  matugen-bin \
  easyeffects \
  hyprshot \
  bibata-cursor-theme \
  tesseract tesseract-data-fra tesseract-data-eng
```

### Fonts

```bash
yay -S \
  ttf-jetbrains-mono-nerd \
  ttf-google-sans \
  ttf-readex-pro \
  ttf-space-grotesk
```

---

## Installation on a new machine

### 1. Clone the repo into `~/.config`

```bash
git init ~/.config
cd ~/.config
git remote add origin <REPO_URL>
git fetch
git checkout main
```

> If `~/.config` already contains files, git will refuse the checkout.
> Back it up first: `cp -r ~/.config ~/.config.bak`

### 2. Generate the color theme

Pick a wallpaper, then run matugen:

```bash
matugen image /path/to/wallpaper.jpg
```

This automatically regenerates:
- `hypr/hyprland/colors.conf`
- `hypr/hyprlock/colors.conf`
- `fuzzel/fuzzel_theme.ini`
- `gtk-3.0/gtk.css` and `gtk-4.0/gtk.css`

### 3. Update personal paths

In `illogical-impulse/config.json`, update:

```json
"background": {
    "wallpaperPath": "/home/YOUR_USER/Pictures/wallpaper.jpg"
},
"screenRecord": {
    "savePath": "/home/YOUR_USER/Videos"
}
```

### 4. Configure monitors

```bash
hyprctl monitors        # list monitor names
# then edit hypr/monitors.conf
```

### 5. API keys (optional — for AI in the sidebar)

API keys are stored in the **system keyring** (gnome-keyring),
never in config files. Configure them via:
`Super + I` → AI tab.

---

## Git workflow

```bash
cd ~/.config
git status
git add hypr/custom/keybinds.conf
git commit -m "feat: ..."
git push
```

---

## Hyprland file structure

```
hypr/
├── hyprland.conf          # Main file (sources all others)
├── hypridle.conf          # Idle timeouts
├── hyprlock.conf          # Lock screen
├── monitors.conf          # Monitor configuration
├── workspaces.conf        # Workspace rules
├── hyprland/              # Default config (upstream)
│   ├── general.conf       # Gaps, animations, input...
│   ├── keybinds.conf      # Keybindings
│   ├── rules.conf         # Window rules
│   ├── execs.conf         # Autostart programs
│   ├── colors.conf        # Colors (generated by matugen)
│   └── scripts/           # Utility scripts
├── hyprlock/
│   └── colors.conf        # Lock screen colors (generated by matugen)
└── custom/                # Personal overrides
    ├── general.conf
    ├── keybinds.conf      # AZERTY optimizations
    ├── rules.conf
    ├── execs.conf
    └── env.conf
```

---

## Notes

- `*.new` and `*.old` files in `hypr/` are comparison/backup files,
  they are **not** versioned.
- `fish/fish_variables` is excluded (fisher runtime state).
- GTK themes and Fuzzel/Hyprland colors are **auto-generated**
  by matugen from the wallpaper.

---

## Credits

This repo is based on the work of **end-4**:

> **dots-hyprland** — https://github.com/end-4/dots-hyprland
>
> Hyprland dotfiles featuring a Quickshell shell (illogical-impulse),
> dynamic Material You theming via matugen, and a wealth of scripts
> and integrations. MIT licensed.

Thanks to end-4 and all contributors for this remarkable work.
