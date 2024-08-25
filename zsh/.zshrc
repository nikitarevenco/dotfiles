#!/bin/sh
HISTFILE=~/.zsh_history

tinyfetch

# completions
autoload -Uz compinit
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -Uz colors && colors

zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)        # Include hidden files.

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# For more plugins: https://github.com/unixorn/awesome-zsh-plugins

source "$ZDOTDIR/functions/core.sh"
source "$ZDOTDIR/functions/util.sh"

# Normal files to source
zsh_add_file "aliases/suffix.sh"
zsh_add_file "aliases/rarely-used.sh"
zsh_add_file "aliases/somewhat-used.sh"
zsh_add_file "aliases/often-used.sh"
zsh_add_file "aliases/fast-travel.sh"
zsh_add_file "aliases/eza.sh"
zsh_add_file "aliases/misc.sh"
zsh_add_file "options.sh"
zsh_add_file "exports.sh"

# Plugins
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-completions"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "Aloxaf/fzf-tab"

# FZF 
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f $ZDOTDIR/completion/_fnm ] && fpath+="$ZDOTDIR/completion/"
compinit

###################################
#   NEED TO BE NEAR END OF FILE   #
###################################

# initialize zoxide
eval "$(zoxide init zsh)"
# Shell integration
eval "$(fzf --zsh)"
# Needs to be at the end of file
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/home/nikita/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
