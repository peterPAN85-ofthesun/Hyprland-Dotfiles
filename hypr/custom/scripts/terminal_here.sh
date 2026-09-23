#!/usr/bin/env bash
# terminal_here.sh
# Ouvre un terminal dans le dossier de travail du terminal actuellement focus.
# Si la fenêtre active n'est pas un terminal (ou si le dossier est introuvable),
# retombe sur le comportement par défaut : un terminal lancé dans $HOME.

launcher=~/.config/hypr/hyprland/scripts/launch_first_available.sh

read -r class pid < <(hyprctl activewindow -j | jq -r '"\(.class // "") \(.pid // 0)"')

cwd=""
case "$class" in
    kitty)
        # kitty tourne en instance unique (-1) : toutes les fenêtres partagent
        # le même PID, seul le remote control sait laquelle a le focus et où
        # elle se trouve. Nécessite `listen_on unix:@kitty` +
        # `allow_remote_control` dans kitty.conf ; kitty suffixe le nom du
        # socket abstrait par son PID, celui que hyprctl vient de donner.
        # Si le socket n'est pas là (kitty lancé avant l'ajout de l'option),
        # on laisse $cwd vide et on retombe sur le lancement par défaut.
        kitty @ --to "unix:@kitty-$pid" launch --type=os-window --cwd=current \
            >/dev/null 2>&1 && exit 0
        ;;
    foot|footclient|Alacritty|org.wezfurlong.wezterm|konsole|xterm|com.mitchellh.ghostty)
        # Un processus par fenêtre : on descend jusqu'au descendant le plus
        # récent (shell, ou programme lancé dedans) et on lit son cwd.
        leaf=$pid
        while child=$(pgrep -n -P "$leaf"); do leaf=$child; done
        cwd=$(readlink -e "/proc/$leaf/cwd")
        ;;
esac

# Le terminal hérite du cwd de ce script.
[[ -n $cwd && -d $cwd ]] && cd "$cwd"

exec "$launcher" "${TERMINAL}" "kitty -1" "foot" "alacritty" "wezterm" "konsole" "kgx" "uxterm" "xterm"
