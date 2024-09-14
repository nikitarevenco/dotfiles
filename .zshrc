setopt prompt_subst

PROMPT='%F{green} ➜ %f'
RPROMPT='%F{blue}$(pwd | sed "s|$HOME|%F{magenta}~%F{blue}|;s|/|%F{white}/%F{blue}|g")%f'

# Compression and scripts
alias zip="7z a -t7z"
alias r="powershell -ExecutionPolicy Bypass -Command '& { \$HOME/dotfiles/scripts/r.ps1 }'"

# Short commands
alias ai="tgpt"
alias s="s -p google"
alias e="eza --icons --git-ignore --sort=changed --across --classify"
alias p="pnpm"
alias b="bat --style=plain --theme ansi"
alias n="nvim -u \$HOME/dotfiles/neovim.lua"
alias l="lazygit"
alias g="git"
alias gr="grep --color=always"
alias dns="doggo"
alias fetch="curlie"
alias bench="hyperfine"

# Utilities
alias dus="dust -bX .git"
alias js='node -e "console.log(\$*)"'
alias ps="powershell -ExecutionPolicy Bypass -File"
alias norg="gron --ungron"
alias mit="curl -s https://raw.githubusercontent.com/nikitarevenco/github-template/main/LICENSE > LICENSE"

# pnpm shortcuts
alias pi="pnpm add"
alias pid="pnpm add -D"
alias px="pnpm dlx"
alias po="pnpm outdated"
alias pu="pnpm update"
alias pl="pnpm list"

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

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function t() {
  z "$@"
  e
}

function precmd() {
    function precmd() {
        echo
    }
}

eval "$(zoxide init zsh)"
