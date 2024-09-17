setopt prompt_subst

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

bindkey -e
# ctrl-right
bindkey "^[[1;5C" forward-word
# ctrl-left
bindkey "^[[1;5D" backward-word

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt extended_glob

PROMPT='%F{green} ➜ %f'
RPROMPT='%F{blue}$(pwd | sed "s|$HOME|%F{magenta}~%F{blue}|;s|/|%F{white}/%F{blue}|g")%f'

# Short commands
alias r="trash"
alias md="mkdir"
alias ai="tgpt"
alias s="s -p google"
alias e="eza --icons --git-ignore --sort=changed --across --classify"
alias p="pnpm"
alias b="bat --style=plain --theme ansi"
alias n="nvim -u \$HOME/dotfiles/neovim.lua"
alias sn="sudo nvim -u \$HOME/dotfiles/neovim.lua"
alias g="git"

# Utilities
alias dus="dust -bX .git"
alias js='node -e "console.log(\$*)"'
alias norg="gron --ungron"

# Fast travel
alias .="cd .. && e"
alias ..="cd ../.. && e"
alias ...="cd ../../.. && e"
alias ....="cd ../../../.. && e"
alias .....="cd ../../../../.. && e"

# eza shortcuts
alias ea="eza --icons --sort=changed --across --classify --all"
alias er="eza --icons --git-ignore --sort=changed --across --classify --recurse --level=2"
alias era="eza --icons --sort=changed --across --classify --all --recurse --level=2"
alias err="eza --icons --git-ignore --sort=changed --across --classify --recurse --level=3"
alias erra="eza --icons --sort=changed --across --classify --all --recurse --level=3"
alias errr="eza --icons --git-ignore --sort=changed --across --classify --recurse"
alias errra="eza --icons --sort=changed --across --classify --all --recurse"
alias ee="eza --icons --git-ignore --sort=changed --across --classify --long --total-size --no-user --no-permissions --git --time-style=relative --git-repos"
alias eea="ee --all"
alias eer="ee --recurse --level=2"
alias eera="ee --all --recurse --level=2"
alias eerr="ee --recurse --level=3"
alias eerra="ee --all --recurse --level=3"
alias eerrr="ee --recurse"
alias eeerrra="ee --all --recurse"

# suffix
alias -s git="git clone"

# Yazi will change directories
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Zoxide but preview files in the directory we are travelling to
function t() {
  z "$@"
  e
}
alias ti="zi"

# Add newline after every prompt except for the first one
function precmd() {
    function precmd() {
        echo
    }
}

# create aliases 1 to 9 that allow me to jump to the 9 previous directories
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# these need to be placed at the end
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
