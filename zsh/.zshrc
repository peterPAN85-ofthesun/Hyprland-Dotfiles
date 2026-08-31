#  ╔═══════════════════════════════════════════════════════════╗
#  ║  zsh — socle oh-my-zsh + plugins « fish-like »            ║
#  ║  Versionné dans le repo dotfiles (~/.config/zsh)          ║
#  ║  Chargé via ZDOTDIR, défini dans ~/.zshenv                ║
#  ╚═══════════════════════════════════════════════════════════╝

# ─── Historique ─────────────────────────────────────────────
# Hors du repo (XDG state) pour que ~/.config/zsh reste 100% versionnable.
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "${HISTFILE:h}"
HISTSIZE=50000
SAVEHIST=50000

setopt HIST_IGNORE_ALL_DUPS   # une seule occurrence de chaque commande
setopt HIST_IGNORE_SPACE      # ' cmd' préfixée d'un espace = non historisée
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY          # historique partagé entre terminaux, comme fish
setopt EXTENDED_HISTORY

# ─── Comportement général (rapprochements avec fish) ────────
setopt AUTO_CD                # 'Documents' seul = cd Documents
setopt AUTO_PUSHD             # pile de répertoires alimentée automatiquement
setopt PUSHD_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS   # '#' utilisable en interactif
setopt NO_BEEP

# ─── oh-my-zsh ──────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

# Cache de complétion hors du repo : son nom contient celui de la machine
# (.zcompdump-<hostname>-<version>), il n'a rien à faire dans git.
# À définir AVANT de sourcer oh-my-zsh, qui appelle compinit.
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
mkdir -p "${ZSH_COMPDUMP:h}"

# Prompt dessiné par le thème oh-my-zsh (et non par starship, contrairement
# à la config fish). 'bira' est un thème deux lignes avec statut git intégré.
ZSH_THEME="bira"

# Les plugins « fish-like » ne viennent PAS d'oh-my-zsh : ils sont fournis par
# pacman et sourcés plus bas, dans un ordre de chargement qui est imposé.
plugins=(git emoji ssh vi-mode vim-interaction zsh-navigation-tools)

source "$ZSH/oh-my-zsh.sh"

# ─── Complétion ─────────────────────────────────────────────
# zsh-completions s'installe dans /usr/share/zsh/site-functions, déjà présent
# dans $fpath. compinit est déjà appelé par oh-my-zsh ci-dessus.

zstyle ':completion:*' menu select                      # menu navigable aux flèches
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # insensible à la casse
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # entrées colorées
zstyle ':completion:*' group-name ''                     # regroupe par catégorie
zstyle ':completion:*:descriptions' format '%F{cyan}── %d ──%f'

# ─── Plugins fish-like (l'ordre ci-dessous est obligatoire) ──
ZSH_PLUGIN_DIR=/usr/share/zsh/plugins

# 1. Autosuggestions — la suggestion grisée de fish
if [[ -r $ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source $ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh
    # fish suggère depuis l'historique ET les complétions
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
fi

# 2. Coloration syntaxique — doit être sourcé APRÈS les autres widgets
if [[ -r $ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source $ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# 3. Recherche d'historique par préfixe — doit être sourcé APRÈS la coloration
if [[ -r $ZSH_PLUGIN_DIR/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source $ZSH_PLUGIN_DIR/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

# ─── Keybindings : vi-mode + touches emacs en insertion ─────
# vi-mode (oh-my-zsh) a posé `bindkey -v`. On réinjecte ici, uniquement dans le
# mode insertion (viins), les raccourcis que fish fournit. Le mode normal vim
# reste intact : Esc y donne accès, hjkl/w/b/dd fonctionnent normalement.

bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^Y' yank
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^?' backward-delete-char       # Backspace franchit le point d'insertion
bindkey -M viins '^H' backward-delete-char

# Déplacement par mot : Alt+←/→ et Ctrl+←/→
for seq in '^[[1;3D' '^[[1;5D' '^[b'; do bindkey -M viins "$seq" backward-word; done
for seq in '^[[1;3C' '^[[1;5C' '^[f'; do bindkey -M viins "$seq" forward-word;  done

# → accepte l'autosuggestion grisée (forward-char est un widget d'acceptation
# par défaut de zsh-autosuggestions). Ctrl+F fait la même chose, comme en fish.
bindkey -M viins '^F' autosuggest-accept

# Home / Fin / Suppr, y compris sous les terminfo « application mode »
bindkey -M viins "${terminfo[khome]:-^[[H}" beginning-of-line
bindkey -M viins "${terminfo[kend]:-^[[F}"  end-of-line
bindkey -M viins "${terminfo[kdch1]:-^[[3~}" delete-char
bindkey -M viins '^[[H' beginning-of-line
bindkey -M viins '^[[F' end-of-line
bindkey -M viins '^[[3~' delete-char

# ↑/↓ filtrent l'historique sur ce qui est déjà tapé — le comportement de fish.
if (( $+widgets[history-substring-search-up] )); then
    for seq in "${terminfo[kcuu1]}" '^[[A' '^[OA'; do
        [[ -n $seq ]] && bindkey -M viins "$seq" history-substring-search-up
    done
    for seq in "${terminfo[kcud1]}" '^[[B' '^[OB'; do
        [[ -n $seq ]] && bindkey -M viins "$seq" history-substring-search-down
    done
    # Même logique avec k/j en mode normal vim
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
fi

# ─── Couleurs Material You (matugen / quickshell) ───────────
# IMPORTANT : les couleurs de kitty ne sont pas dans kitty.conf. Elles sont
# générées par quickshell/ii/scripts/colors/applycolor.sh et injectées dans le
# terminal sous forme de séquences d'échappement. Sans ce bloc, on retombe sur
# la palette par défaut de kitty. Équivalent du même bloc dans config.fish.
_ii_sequences="$HOME/.local/state/quickshell/user/generated/terminal/sequences.txt"
[[ -f $_ii_sequences ]] && cat "$_ii_sequences"
unset _ii_sequences

# Note : pas de `starship init zsh` ici. starship écrase PROMPT et masquerait
# entièrement le thème bira. Le prompt zsh diffère donc volontairement du
# prompt fish, qui lui reste sur starship.

# ─── Alias (repris de config.fish) ──────────────────────────
alias pamcan='pacman'
alias ls='eza --icons auto'
alias clear="printf '\033[2J\033[3J\033[1;1H'"
alias q='qs -c ii'

# ─── PATH ───────────────────────────────────────────────────
# Ajout idempotent : évite le doublon présent dans l'ancienne config.
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"

# ─── PS2DEV ───────────────────────────────────────────────────
export PS2DEV=/usr/local/ps2dev
export PS2SDK=$PS2DEV/ps2sdk
export GSKIT=$PS2DEV/gsKit
export PATH=$PATH:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin
