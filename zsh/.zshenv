# Set Zsh configuration directory
export CONFIG="${HOME}/.config"
export PRIME="${HOME}/prime"
export DOTFILES="${PRIME}/dots"
export PASSWORD_STORE_DIR="${PRIME}/pass"
export ZDOTDIR="${CONFIG}/zsh"
export TRASH="${HOME}/.local/share/Trash"
export WALLPAPER="${PRIME}/pics/wallpaper/arch.png"

# Add directories to PATH
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.local/share/go/bin:$HOME/.fnm:$HOME/.local/share/neovim/bin:$HOME/.local/share/fnm:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:$(npm bin -g)"

# Other environment variables
export BAT_THEME="Catppuccin Mocha"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export GIT_CONFIG_GLOBAL="$HOME/.config/git/.gitconfig"
export XINITRC="$HOME/.config/xinit/.xinitrc"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'

# Set default editor and terminal
export EDITOR="nvim"
export TERMINAL="kitty"

# Starship prompt configuration
export STARSHIP_CONFIG=~/.config/starship/starship.toml
