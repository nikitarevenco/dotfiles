## Nikita Revenco Linux and Windows Dotfiles

My minimalistic dotfiles for max productivity.

## Packages

|Package|Purpose|
|-|-|
|nodejs|lang|
|luajit|lang|
|ruby|lang|
|python|lang|
|pnpm|better `npm`|
|luarocks|package manager for lua|
|dotnet-sdk|lang|
|julia|lang|
|duf|better `df`|
|bat|better `cat`|
|dust|better `du`|
|fzf|fuzzy finder|
|onefetch|git repo stats|
|fd|better `find`|
|neovim|editor|
|ripgrep|better `grep`|
|tgpt|ai prompt|
|sd|better `sed`|
|zoxide|better `cd`|
|hyperfine|benchmarking tool|
|yq|yaml,json processor|
|wezterm|terminal emulator|
|firefox|browser|
|JetBrainsMono NF|monospace font|
|flameshot|screenshot software|
|git|version control|
|gimp|image editor|
|gron|make json greppable|
|eza|better `ls`|
|procs|better `ps`|
|curlie|better `curl`|
|i3-wm|tiling window manager|
|dmenu|program runner|
|xorg-xinit|x session starter script|
|xorg-server|x server to run i3|
|noto-fonts|various fonts|
|noto-fonts-emoji|render emojis|
|noto-fonts-cjk|render cjk characters|
|pulseaudio|to make Volume Up,Down,Toggle keys work|
|brightnessctl|to make Brightness Up and Down keys work|
|trash-cli|like `rm` but we can recover|
|xclip|clipboard manager|
|zsh|shell|
|zsh-syntax-highlighting|zsh plugin|
|zsh-autosuggestions|zsh plugin|
|zsh-autopairs|zsh plugin|
|fzf-tab-source|use fzf for tab completion|
|boomer|zoom in|

## Quick Setup

Installation command for packages

```bash
sudo pacman -S --noconfirm i3-wm dmenu xorg-xinit xorg-server pulseaudio trash-cli nodejs luajit ruby python pnpm luarocks dotnet-sdk julia duf bat dust fzf fd neovim ripgrep tgpt sd zoxide hyperfine yq wezterm firefox git gron eza procs curlie zsh zsh-syntax-highlighting zsh-autosuggestions xclip brightnessctl noto-fonts-emoji flameshot ttf-jetbrains-mono-nerd onefetch
```

Also install yay

```bash
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -rf yay
  ```

And install yay packages

```bash
yay -S --noconfirm boomer fzf-tab-source gimp-git zsh-autopair
  ```

---

This single command will generate Git SSH keys and copy them into clipboard so I can easily setup Git and GitHub on a new computer in just 2 seconds

```
mkdir -p "$HOME/.ssh" && ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -N "" && cat "$HOME/.ssh/id_ed25519.pub"
```

---

Now just clone this repo into `~/dotfiles` (it needs to be there since all the env variables in `wezterm.lua` point to that place) and launch wezterm

```bash
git clone https://github.com/nikitarevenco/dotfiles %USERPROFILE%\dotfiles
```
---

Create symlinks:

```
mkdir -p ~/.config/i3 && ln -s ~/dotfiles/i3 ~/.config/i3/config && echo "source ~/dotfiles/zsh" > ~/.zshrc
```
