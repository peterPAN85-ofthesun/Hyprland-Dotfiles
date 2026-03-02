# Modifications AZERTY appliquées ✅

**Date :** 2026-01-12
**Fichier modifié :** `~/.config/hypr/custom/keybinds.conf`

---

## 📝 Résumé des changements

Les optimisations AZERTY ont été appliquées avec succès dans votre fichier de configuration personnalisé.

### Raccourcis désactivés (problématiques sur AZERTY)

| Raccourci | Raison |
|-----------|--------|
| `Super + Semicolon` | Semicolon = Shift+, sur AZERTY (peu pratique) |
| `Super + Apostrophe` | Apostrophe = touche 4 sur AZERTY (peu pratique) |
| `Super + [ ]` | Crochets = AltGr+( ) sur AZERTY + redondant avec flèches |
| `Ctrl+Super + [ ]` | Redondant avec Ctrl+Super + Left/Right |
| `Super + Slash` | Slash = Shift+: sur AZERTY (peu pratique) |

### Nouveaux raccourcis (optimisés AZERTY)

| Nouveau raccourci | Fonction | Détails |
|-------------------|----------|---------|
| `Super+Ctrl + ,` (Comma) | Réduire ratio split | Touche virgule facilement accessible |
| `Super+Ctrl + .` (Period) | Augmenter ratio split | Touche point facilement accessible |
| `Super + H` | Afficher l'aide | H = Help, très ergonomique |

---

## 🚀 Comment appliquer les changements

### Option 1 : Recharger Hyprland (depuis votre session)
Utilisez le raccourci existant :
```
Ctrl + Super + R
```

### Option 2 : Redémarrer Hyprland
Si vous êtes dans une session Hyprland, déconnectez-vous et reconnectez-vous.

### Option 3 : Commande manuelle
```bash
hyprctl reload
```

---

## 🎮 Nouveaux raccourcis à mémoriser

### Ajustement du ratio de split
- **`Super + Ctrl + ,`** : Réduire la taille de la fenêtre active
- **`Super + Ctrl + .`** : Augmenter la taille de la fenêtre active

### Aide
- **`Super + H`** : Afficher le cheatsheet des raccourcis

---

## 📍 Emplacement des fichiers

- **Configuration principale** : `~/.config/hypr/hyprland.conf`
- **Keybinds par défaut** : `~/.config/hypr/hyprland/keybinds.conf` (non modifié)
- **Vos personnalisations** : `~/.config/hypr/custom/keybinds.conf` (modifié ✅)
- **Analyse complète** : `~/.config/hypr/AZERTY_ANALYSIS.md`

---

## 🔄 Restauration

Si vous souhaitez annuler ces changements, éditez simplement :
```bash
nano ~/.config/hypr/custom/keybinds.conf
```

Et supprimez la section "AZERTY Optimizations" (lignes 25-46).

---

## ✨ Personnalisations supplémentaires

Vous pouvez ajouter vos propres raccourcis dans `custom/keybinds.conf` après la section AZERTY.

Exemple :
```conf
# Mes raccourcis personnels
bind = Super, Y, exec, kitty  # Ouvrir un terminal avec Y
```

---

## 📚 Ressources

- [Wiki Hyprland - Binds](https://wiki.hyprland.org/Configuring/Binds/)
- [Liste des keycodes](https://wiki.hyprland.org/Configuring/Binds/#binding-flags)
- Configuration actuelle : Voir `AZERTY_ANALYSIS.md` pour l'analyse complète

---

**Prochaines étapes suggérées :**
1. Rechargez Hyprland avec `Ctrl+Super+R`
2. Testez les nouveaux raccourcis
3. Consultez l'aide avec `Super+H`
4. Personnalisez selon vos besoins !

**Bon usage ! 🎉**
