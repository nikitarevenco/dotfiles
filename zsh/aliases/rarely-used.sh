alias myip='ip a | grep "inet " | grep -v 127.0.0.1'
alias relink="bash $DOTFILES/.install/create-symlinks.sh ; resource"
alias imtheowner="sudo chown -R $(whoami) ."
alias m="pass show -c"
# do not ask for password during the current session (or 72 hours)
alias pass-relax='gpgconf --kill gpg-agent && export GPG_TTY=$(tty) && gpg-agent --daemon --default-cache-ttl 259200 --max-cache-ttl 259200 && pass show .passignore'
# restart pass session
alias pass-kill="gpgconf --kill gpg-agent"
alias prime-copy='sudo mkdir -p prime && find "$PRIME" -mindepth 1 -maxdepth 1 -print0 | while IFS= read -r -d "" item; do if [ -d "$item/.git" ]; then sudo git clone "$item" "prime/$(basename "$item")"; else sudo cp -r "$item" prime/; fi; done'
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"
