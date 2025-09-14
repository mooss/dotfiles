# Prevent the insufferable default behavior of skipping the space whith word forward and backwards.
bindkey '^[f' emacs-forward-word
bindkey '^[b' emacs-backward-word

setopt nocorrectall # Stop invasive correction to neighboring filename.
setopt no_share_history # Don't share history across sessions.
PATH=$PATH:$HOME/.local/bin

