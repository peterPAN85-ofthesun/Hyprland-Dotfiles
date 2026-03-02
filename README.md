# Dotfiles — Configuration Hyprland

Config Hyprland personnalisée basée sur [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland).

## Logiciels inclus

| Logiciel | Rôle |
|---|---|
| [Hyprland](https://hyprland.org) | Compositeur Wayland |
| [Hyprlock](https://github.com/hyprwm/hyprlock) | Écran de verrouillage |
| [Hypridle](https://github.com/hyprwm/hypridle) | Gestion de l'inactivité |
| [Quickshell](https://quickshell.outfoxxed.me/) (illogical-impulse) | Bar / widgets / shell |
| [Kitty](https://sw.kovidgoyal.net/kitty/) | Terminal principal |
| [Foot](https://codeberg.org/dnkl/foot) | Terminal secondaire |
| [Fuzzel](https://codeberg.org/dnkl/fuzzel) | Lanceur d'applications |
| [Wlogout](https://github.com/ArtsyMacaw/wlogout) | Menu de session |
| [Cava](https://github.com/karlstav/cava) | Visualiseur audio |
| [Matugen](https://github.com/InioX/matugen) | Génération de thèmes Material You |
| [Fish](https://fishshell.com/) | Shell |
| [Starship](https://starship.rs/) | Prompt |
| [MPV](https://mpv.io/) | Lecteur multimédia |

## Raccourcis clavier

> La touche **Super** = touche Windows.
> Layout **AZERTY** — certains raccourcis ont été adaptés (voir section Custom).

### Shell & Interface

| Raccourci | Action |
|---|---|
| `Super` | Recherche / Lanceur |
| `Super + Tab` | Vue d'ensemble des workspaces |
| `Super + A` | Sidebar gauche |
| `Super + N` | Sidebar droite |
| `Super + H` | Cheatsheet (aide raccourcis) |
| `Super + J` | Afficher/masquer la bar |
| `Super + M` | Contrôles média |
| `Super + G` | Overlay |
| `Super + K` | Clavier virtuel |
| `Super + V` | Historique du presse-papier |
| `Super + .` | Sélecteur d'emojis |
| `Ctrl+Super + R` | Redémarrer les widgets |
| `Ctrl+Super + P` | Changer de famille de panneaux |
| `Ctrl+Alt + Suppr` | Menu de session |

### Captures & Enregistrement

| Raccourci | Action |
|---|---|
| `Impr écran` | Screenshot plein écran → presse-papier |
| `Ctrl + Impr écran` | Screenshot → presse-papier & fichier |
| `Super+Shift + S` | Capture de zone → presse-papier |
| `Super+Shift + A` | Capture de zone → Google Lens |
| `Super+Shift + X` | OCR sur une zone → presse-papier |
| `Super+Shift + C` | Pipette couleur (Hex) → presse-papier |
| `Super+Shift + R` | Enregistrer une région (sans son) |
| `Ctrl+Alt + R` | Enregistrer l'écran (sans son) |
| `Super+Shift+Alt + R` | Enregistrer l'écran (avec son) |
| `Ctrl+Super + T` | Sélecteur de fond d'écran |
| `Ctrl+Super+Alt + T` | Fond d'écran aléatoire |

### Luminosité & Volume

| Raccourci | Action |
|---|---|
| `🔆 / 🔅` (touches fn) | Luminosité + / - |
| `🔊 / 🔉` (touches fn) | Volume + / - |
| `🔇` (touche fn) | Mute sortie audio |
| `Super+Shift + M` | Mute sortie audio |
| `Alt + 🔇` / `Super+Alt + M` | Mute microphone |

### Fenêtres

| Raccourci | Action |
|---|---|
| `Super + ←/↑/→/↓` | Focus dans la direction |
| `Super+Shift + ←/↑/→/↓` | Déplacer la fenêtre |
| `Super + clic gauche` (drag) | Déplacer la fenêtre |
| `Super + clic droit` (drag) | Redimensionner la fenêtre |
| `Super + Q` / `Alt + F4` | Fermer la fenêtre |
| `Super+Shift+Alt + Q` | Forcer la fermeture |
| `Super+Alt + Espace` | Basculer flottant / tuilé |
| `Super + D` | Maximiser |
| `Super + F` | Plein écran |
| `Super+Alt + F` | Plein écran (spoof) |
| `Super + P` | Épingler la fenêtre |
| `Super+Ctrl + ,` | Réduire le ratio de split *(AZERTY)* |
| `Super+Ctrl + .` | Augmenter le ratio de split *(AZERTY)* |
| `Ctrl+Super + \` | Forcer la taille à 640×480 |

### Workspaces

| Raccourci | Action |
|---|---|
| `Super + 1…0` | Aller au workspace 1–10 |
| `Super+Alt + 1…0` | Envoyer la fenêtre au workspace 1–10 |
| `Ctrl+Super + ←/→` | Workspace précédent / suivant |
| `Super + PageHaut/Bas` | Workspace précédent / suivant |
| `Super + S` | Afficher/masquer le scratchpad |
| `Super+Alt + S` | Envoyer au scratchpad |

### Session

| Raccourci | Action |
|---|---|
| `Super + L` | Verrouiller l'écran |
| `Super+Shift + L` | Suspendre le système |
| `Ctrl+Shift+Alt+Super + Suppr` | Éteindre |

### Zoom écran

| Raccourci | Action |
|---|---|
| `Super + -` | Dézoomer |
| `Super + =` | Zoomer |

### Média

| Raccourci | Action |
|---|---|
| `Super+Shift + P` | Lecture / Pause |
| `Super+Shift + N` | Piste suivante |
| `Super+Shift + B` | Piste précédente |
| Touches média (fn) | Lecture / Pause / Suivant / Précédent |

### Applications

| Raccourci | Action |
|---|---|
| `Super + Entrée` | Terminal (kitty) |
| `Super + E` | Gestionnaire de fichiers (dolphin) |
| `Super + W` | Navigateur web |
| `Super + C` | Neovim (dans kitty) |
| `Super + X` | Obsidian |
| `Ctrl+Super + V` | Mixeur audio (pavucontrol-qt) |
| `Super + I` | Paramètres |
| `Ctrl+Shift + Échap` | Gestionnaire de tâches |

---

## Dépendances

### Paquets pacman

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

### Paquets AUR

```bash
yay -S \
  quickshell-git \
  matugen-bin \
  easyeffects \
  hyprshot \
  bibata-cursor-theme \
  tesseract tesseract-data-fra tesseract-data-eng
```

### Polices

```bash
yay -S \
  ttf-jetbrains-mono-nerd \
  ttf-google-sans \
  ttf-readex-pro \
  ttf-space-grotesk
```

---

## Installation sur une nouvelle machine

### 1. Cloner le repo dans `~/.config`

```bash
git init ~/.config
cd ~/.config
git remote add origin <URL_DU_REPO>
git fetch
git checkout main
```

> Si `~/.config` contient déjà des fichiers, git refusera le checkout.
> Faire une sauvegarde avant : `cp -r ~/.config ~/.config.bak`

### 2. Générer le thème couleurs

```bash
matugen image /chemin/vers/wallpaper.jpg
```

Cela régénère automatiquement :
- `hypr/hyprland/colors.conf`
- `hypr/hyprlock/colors.conf`
- `fuzzel/fuzzel_theme.ini`
- `gtk-3.0/gtk.css` et `gtk-4.0/gtk.css`

### 3. Ajuster les chemins personnels

Dans `illogical-impulse/config.json`, mettre à jour :

```json
"background": {
    "wallpaperPath": "/home/TON_USER/Images/wallpaper.jpg"
},
"screenRecord": {
    "savePath": "/home/TON_USER/Vidéos"
}
```

### 4. Configurer les moniteurs

```bash
hyprctl monitors        # voir les noms des écrans
# puis éditer hypr/monitors.conf
```

### 5. Clés API (optionnel — pour l'IA dans la sidebar)

Les clés API sont stockées dans le **keyring système** (gnome-keyring),
jamais dans les fichiers de config. Les configurer via :
`Super + I` → onglet AI.

---

## Workflow git

```bash
cd ~/.config
git status
git add hypr/custom/keybinds.conf
git commit -m "feat: ..."
git push
```

---

## Structure des fichiers Hyprland

```
hypr/
├── hyprland.conf          # Fichier principal (source les autres)
├── hypridle.conf          # Timeouts d'inactivité
├── hyprlock.conf          # Écran de verrouillage
├── monitors.conf          # Configuration des moniteurs
├── workspaces.conf        # Règles de workspaces
├── hyprland/              # Config par défaut (upstream)
│   ├── general.conf       # Gaps, animations, input...
│   ├── keybinds.conf      # Raccourcis clavier
│   ├── rules.conf         # Règles de fenêtres
│   ├── execs.conf         # Programmes au démarrage
│   ├── colors.conf        # Couleurs (généré par matugen)
│   └── scripts/           # Scripts utilitaires
├── hyprlock/
│   └── colors.conf        # Couleurs du lock screen (généré par matugen)
└── custom/                # Tes overrides personnels
    ├── general.conf
    ├── keybinds.conf      # Optimisations AZERTY
    ├── rules.conf
    ├── execs.conf
    └── env.conf
```

---

## Notes

- Les fichiers `*.new` et `*.old` dans `hypr/` sont des fichiers de
  comparaison, ils ne sont **pas** versionnés.
- `fish/fish_variables` est exclu (état runtime de fisher).
- Les thèmes GTK et les couleurs Fuzzel/Hyprland sont **auto-générés**
  par matugen depuis le fond d'écran.
- Basé sur [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland) —
  merci à end-4 pour le travail remarquable.
