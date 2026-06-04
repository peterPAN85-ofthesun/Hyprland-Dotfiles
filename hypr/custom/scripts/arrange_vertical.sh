#!/usr/bin/env bash
# arrange_vertical.sh u|d [fallback_dispatcher]
# Avec exactement 2 fenêtres tilées dans le workspace de la fenêtre active :
# les empile verticalement avec l'active en haut (u) ou en bas (d).
# Sinon : exécute `hyprctl dispatch <fallback_dispatcher> <dir>` (def: movefocus).

dir="$1"
fallback="${2:-movefocus}"

active=$(hyprctl activewindow -j)
active_addr=$(echo "$active" | jq -r .address)
ws=$(echo "$active" | jq -r .workspace.id)

clients=$(hyprctl clients -j | jq "[.[] | select(.workspace.id == $ws and .floating == false)]")
count=$(echo "$clients" | jq 'length')

if [ "$count" -ne 2 ]; then
    hyprctl dispatch "$fallback" "$dir"
    exit 0
fi

active_y=$(echo "$clients" | jq ".[] | select(.address == \"$active_addr\") | .at[1]")
other_y=$(echo "$clients" | jq ".[] | select(.address != \"$active_addr\") | .at[1]")

if [ "$active_y" = "$other_y" ]; then
    hyprctl dispatch layoutmsg togglesplit
    clients=$(hyprctl clients -j | jq "[.[] | select(.workspace.id == $ws and .floating == false)]")
    active_y=$(echo "$clients" | jq ".[] | select(.address == \"$active_addr\") | .at[1]")
    other_y=$(echo "$clients" | jq ".[] | select(.address != \"$active_addr\") | .at[1]")
fi

case "$dir" in
    u) [ "$active_y" -gt "$other_y" ] && hyprctl dispatch layoutmsg swapsplit ;;
    d) [ "$active_y" -lt "$other_y" ] && hyprctl dispatch layoutmsg swapsplit ;;
esac
