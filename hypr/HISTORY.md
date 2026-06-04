# Hyprland Configuration History

| # | Date & Time | Commande / Action | Explication succincte |
|---|-------------|-------------------|-----------------------|
| 1 | 2026-03-22 00:34 | `exec-once = bash -c 'sleep 3 && pactl set-source-volume alsa_input.pci-0000_06_00.6.analog-stereo 28%'` | Fixe le gain du micro analog-stereo à 28% au démarrage (après 3 s) via pactl pour éviter un niveau trop élevé. |
| 2 | 2026-06-04 13:15 | `hyprland/general.conf` — suppression de `ignore_window = true` dans `decoration:shadow` | Option supprimée dans Hyprland 0.55.2 ; son maintien provoquait une erreur de config au rechargement. |
| 3 | 2026-06-04 13:15 | `hyprland/general.conf` — suppression de `vfr = 1` dans `misc` | Option supprimée dans Hyprland 0.55.2 ; le VFR est désormais géré automatiquement par le compositor. |
| 4 | 2026-06-04 13:15 | `binde = Super, Semicolon/Apostrophe, layoutmsg, splitratio ±0.1` | Migre les binds de splitratio vers `layoutmsg` (dispatcher renommé dans Hyprland 0.55.2) dans `hyprland/keybinds.conf`. |
| 5 | 2026-06-04 13:15 | `binde = Super+Ctrl, Comma/Period, layoutmsg, splitratio ±0.1` | Migre les binds AZERTY de splitratio vers `layoutmsg` (dispatcher renommé dans Hyprland 0.55.2) dans `custom/keybinds.conf`. |
