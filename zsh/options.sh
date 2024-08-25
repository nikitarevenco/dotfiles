#!/bin/sh

HISTSIZE=1000000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory

# extended pattern matching
setopt extended_glob
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt extendedglob nomatch menucomplete
setopt correct
setopt interactive_comments
stty stop undef        # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# speedy keys
xset r rate 200 30

# Case-insensitive completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Color in completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' menu no

zstyle ':fzf-tab:complete:one_command_to_rule_them_all:*' fzf-preview 'eza --all --git --icons --classify --group-directories-first --time-style=long-iso --group --color-scale --color=always $realpath'

eza_params=('--all' '--git' '--icons' '--classify' '--group-directories-first' '--time-style=long-iso' '--group' '--color-scale')
# bindkey '^e' edit-command-line
bindkey '^e' expand-word
bindkey '^t' history-search-backward
bindkey '^n' history-search-forward
bindkey -e

# beeping is annoying
unsetopt BEEP
