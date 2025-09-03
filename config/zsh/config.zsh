# Prevent the insufferable default behavior of skipping the space whith word forward and backwards.
bindkey '^[f' emacs-forward-word
bindkey '^[b' emacs-backward-word

setopt nocorrectall
PATH=$PATH:$HOME/.local/bin
