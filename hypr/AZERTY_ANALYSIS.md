# Analyse des raccourcis Hyprland pour clavier AZERTY

## Résumé
Cette analyse identifie les raccourcis clavier qui sont problématiques sur un clavier AZERTY français et propose des alternatives ergonomiques.

---

## 🔴 Raccourcis TRÈS PROBLÉMATIQUES (à changer en priorité)

### 1. Ajustement du ratio de split (lignes 112-113)
**Problème :** Utilise `Semicolon` et `Apostrophe` qui sont très mal placés sur AZERTY
```conf
binde = Super, Semicolon, splitratio, -0.1  # Semicolon = Shift+, (virgule)
binde = Super, Apostrophe, splitratio, +0.1 # Apostrophe = touche 4
```

**Alternatives suggérées :**
- Option A (arithmétique) : `Super + Minus` et `Super + Plus`
  - ⚠️ Conflit avec Zoom (lignes 233-241)
- Option B (flèches) : Déjà utilisé pour focus
- Option C (virgule/point) : `Super + Comma` et `Super + Period`
  - ⚠️ Conflit partiel avec `Super + Period` (Emoji, ligne 27)
- **Option D (recommandée)** : `Super+Ctrl + Comma` et `Super+Ctrl + Period`
- **Option E (alternative)** : `Super + < (moins que)` et `Super + > (plus que)`

---

### 2. Focus avec crochets (lignes 98-99)
**Problème :** Les crochets nécessitent `AltGr` sur AZERTY
```conf
bind = Super, BracketLeft, movefocus, l   # AltGr + ( = [
bind = Super, BracketRight, movefocus, r  # AltGr + ) = ]
```

**Alternatives suggérées :**
- **Option A (recommandée)** : Déjà remplacé par flèches (lignes 94-97), ces binds sont redondants
- **Option B** : Supprimer ces lignes (fonctionnalité déjà couverte)

---

### 3. Workspace navigation avec crochets (lignes 208-209)
**Problème :** Même problème que ci-dessus
```conf
bind = Ctrl+Super, BracketLeft, workspace, -1
bind = Ctrl+Super, BracketRight, workspace, +1
```

**Alternatives suggérées :**
- **Déjà couvert** par `Ctrl+Super + Left/Right` (lignes 190-191)
- **Recommandation** : Supprimer ces lignes redondantes

---

## 🟡 Raccourcis MOYENNEMENT PROBLÉMATIQUES

### 4. Toggle cheatsheet (ligne 33)
**Problème :** `Slash` = `Shift + :` sur AZERTY
```conf
bindd = Super, Slash, Toggle cheatsheet, global, quickshell:cheatsheetToggle
```

**Alternatives suggérées :**
- **Option A** : `Super + ?` (qui est `Shift + ,` sur AZERTY)
- **Option B** : `Super + H` (comme "Help")
- **Option C (recommandée)** : `Super + Shift + Slash` (devient Super + Shift + Shift + : = Super + ?)
- **Option D** : `F1` (traditionnellement l'aide)

---

## 🟢 Raccourcis qui FONCTIONNENT correctement sur AZERTY

### Chiffres pour workspaces (lignes 167-187)
✅ **Utilise des keycodes bruts** (`code:10`, `code:11`, etc.)
- Fonctionne indépendamment du layout clavier
- Pas de modification nécessaire

### Flèches directionnelles (lignes 94-97, 101-104)
✅ **Position identique sur AZERTY et QWERTY**
```conf
bind = Super, Left/Right/Up/Down  # Fonctionne parfaitement
```

### Touches de fonction (F1-F12)
✅ **Position identique sur tous les claviers**

### Touches modificatrices
✅ **Super, Ctrl, Alt, Shift** - Position identique

---

## 📊 Récapitulatif des modifications recommandées

| Raccourci actuel | Ligne | Problème | Solution recommandée |
|------------------|-------|----------|----------------------|
| `Super + Semicolon` | 112 | Shift+, sur AZERTY | `Super+Ctrl + Comma` |
| `Super + Apostrophe` | 113 | Touche 4 sur AZERTY | `Super+Ctrl + Period` |
| `Super + BracketLeft` | 98 | AltGr+( sur AZERTY | Supprimer (redondant) |
| `Super + BracketRight` | 99 | AltGr+) sur AZERTY | Supprimer (redondant) |
| `Ctrl+Super + BracketLeft` | 208 | AltGr+( sur AZERTY | Supprimer (redondant) |
| `Ctrl+Super + BracketRight` | 209 | AltGr+) sur AZERTY | Supprimer (redondant) |
| `Super + Slash` | 33 | Shift+: sur AZERTY | `Super + H` ou `F1` |

---

## 🎯 Touches facilement accessibles sur AZERTY

Pour vos futures personnalisations, voici les touches facilement accessibles :

### Lettres libres ou peu utilisées
- `Super + Y`, `Super + U`, `Super + R` (peu/pas utilisées)
- Combinaisons avec `Shift` sur touches peu utilisées

### Touches de ponctuation accessibles
- `,` (virgule) - accessible
- `.` (point) - accessible
- `-` (moins/tiret) - accessible mais utilisé pour zoom
- `=` (égal) - accessible mais utilisé pour zoom

### Touches spéciales
- `Espace` - très accessible
- `Tab` - déjà utilisé pour overview
- `Backspace` - partiellement utilisé

---

## 💡 Suggestions de personnalisation

### Pour usage personnel AZERTY optimisé

1. **Créer un fichier custom/keybinds.conf** avec vos modifications
2. **Conserver les defaults** dans hyprland/keybinds.conf
3. **Override uniquement les raccourcis problématiques**

Exemple de structure :
```conf
# custom/keybinds.conf
# Ajustements AZERTY - override des raccourcis problématiques

# Ajustement ratio de split (remplace Semicolon/Apostrophe)
binde = Super+Ctrl, Comma, splitratio, -0.1
binde = Super+Ctrl, Period, splitratio, +0.1

# Cheatsheet plus accessible
bindd = Super, H, Toggle cheatsheet, global, quickshell:cheatsheetToggle

# Suppression des raccourcis redondants avec crochets
unbind = Super, BracketLeft
unbind = Super, BracketRight
unbind = Ctrl+Super, BracketLeft
unbind = Ctrl+Super, BracketRight
```

---

## ⚙️ Prochaines étapes

1. **Tester les conflits** : Vérifier si les nouvelles touches sont déjà utilisées
2. **Appliquer les modifications** dans `custom/keybinds.conf`
3. **Reload Hyprland** : `Ctrl+Super+R` pour tester
4. **Ajuster selon vos préférences** personnelles

---

**Date de génération :** 2026-01-12
**Configuration analysée :** ~/.config/hypr/hyprland/keybinds.conf
