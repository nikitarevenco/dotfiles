# vim: set filetype=zsh :
setopt prompt_subst

autoload -Uz compinit && compinit
# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

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
RPROMPT='%F{blue}$(pwd | sed "s|$HOME|%F{magenta}~%F{blue}|;s|/|%F{white}/ %F{blue}|g")%f '

# Short commands
alias r="trash"
alias md="mkdir"
alias ai="tgpt"
alias s="s -p google"
alias e="eza --git-ignore --sort=changed --across --classify"
alias pac="sudo pacman --color=always"
alias p="pnpm"

# if its an img file or similar show it in the terminal, otherwise show contents of the text file
function b() {
    for file in "$@"; do
        if [[ "$file" =~ \.(png|jpg|jpeg|gif|bmp|tiff|svg)$ ]]; then
            wezterm imgcat "$file"
        else
            bat --style=plain --theme ansi "$file"
        fi
    done
}
alias n="nvim"
alias sn="sudo nvim -u $HOME/.config/nvim/init.lua"
alias n.="n ."
alias g="git"

# Utilities
alias onefetch="onefetch --no-art --no-color-palette --nerd-fonts --true-color never"
alias duf="duf -theme ansi"
alias dust="dust -bX .git"
alias js='node -e "console.log(\$*)"'
alias norg="gron --ungron"

# Fast travel
alias .="cd .. && e"
alias ..="cd ../.. && e"
alias ...="cd ../../.. && e"
alias ....="cd ../../../.. && e"
alias .....="cd ../../../../.. && e"

# eza shortcuts
alias ea="eza --sort=changed --across --classify --all"
alias er="eza --git-ignore --sort=changed --across --classify --recurse --level=2"
alias era="eza --sort=changed --across --classify --all --recurse --level=2"
alias err="eza --git-ignore --sort=changed --across --classify --recurse --level=3"
alias erra="eza --sort=changed --across --classify --all --recurse --level=3"
alias errr="eza --git-ignore --sort=changed --across --classify --recurse"
alias errra="eza --sort=changed --across --classify --all --recurse"
alias ee="eza --git-ignore --sort=changed --across --classify --long --total-size --no-user --no-permissions --git --time-style=relative --git-repos"
alias eea="ee --all"
alias eer="ee --recurse --level=2"
alias eera="ee --all --recurse --level=2"
alias eerr="ee --recurse --level=3"
alias eerra="ee --all --recurse --level=3"
alias eerrr="ee --recurse"
alias eeerrra="ee --all --recurse"
alias mirrors="sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist"

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

export PATH=/home/e/.deno/bin:$PATH

# these need to be placed at the end
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

function add_zsh_plugin() {
    local repo_url="$1"
    local source_file="$2"
    local name=$(basename -s .git "$repo_url")
    local plugin_dir="$HOME/.zsh-plugins/$name"

    if [[ ! -d "$plugin_dir" ]]; then
        git clone "$repo_url" "$plugin_dir" && \
    fi

    source "$plugin_dir/$source_file"
}

add_zsh_plugin https://github.com/zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting.zsh
add_zsh_plugin https://github.com/Aloxaf/fzf-tab fzf-tab.zsh
add_zsh_plugin https://github.com/hlissner/zsh-autopair autopair.zsh
add_zsh_plugin https://github.com/zsh-users/zsh-autosuggestions zsh-autosuggestions.zsh
