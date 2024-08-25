alias c="clear && tinyfetch"

# Copy output of previous terminal command to clipboard
alias yy='fc -ln -1 | xargs -I {} sh -c "{}" | tee /tmp/cmdoutput | xsel -b'

# Use instead of rm, this one will just trash. A lot more safe
alias r="trash-put"
alias \?="google_search"
alias g='git'
alias n="nvim"
alias l="lazygit"
alias G='grep --color=auto'
alias -g B="| bat --style=plain"
alias -g Y="| xclip -selection clipboard"
alias ga="git config --list | grep '^alias\.' | sed 's/^alias\.//g' | awk -F '=' '{printf \"\\033[0;32m%s\\033[0m = %s\\n\", \$1, \$2}' | fzf --ansi --preview 'echo {}' --preview-window=up:1:wrap | awk -F '=' '{print \"g \" \$1}' | xargs -I {} bash -c 'xdotool type --delay 0 --clearmodifiers \"{}\" && xdotool key Return'"
alias vpn="sudo openvpn --config /etc/openvpn/client/us.protonvpn.udp.ovpn"
alias update-mirrorlist="sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist"
alias next="git clone git@github.com:nikitarevenco/nextjs-skeleton-base.git"

# If it's an image, showcase it. If its a regular file, show its contents
alias i='open_file'
alias b='bpytop'
alias p="pnpm"
alias now="tinytime"
alias makebak="backup-current-directory"

alias loc="lines_of_code"

alias resource="source $ZDOTDIR/.zshrc"
alias run="nodemon --quiet --exec \"clear && node script.js\" 2>&1 | grep -v '\[nodemon\]'"
