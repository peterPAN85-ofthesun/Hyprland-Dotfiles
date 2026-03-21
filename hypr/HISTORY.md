# Hyprland Configuration History

| # | Date & Time | Commande / Action | Explication succincte |
|---|-------------|-------------------|-----------------------|
| 1 | 2026-03-22 00:34 | `exec-once = bash -c 'sleep 3 && pactl set-source-volume alsa_input.pci-0000_06_00.6.analog-stereo 28%'` | Fixe le gain du micro analog-stereo à 28% au démarrage (après 3 s) via pactl pour éviter un niveau trop élevé. |
