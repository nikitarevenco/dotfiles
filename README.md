## Nikita Revenco Linux and Windows Dotfiles

My ideal linux and windows setup for development, designed for productivity

### Packages

I usually forget why I install certain stuff so I keep note of all the packages in this table.

<details>
<summary>
packages
</summary>

#### Language Specific tools

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

#### General tools

|Package|Purpose|
|----|----|
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
|yazi|file manager|
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

#### Windows only

|Package|Purpose|
|-|-|
|clink|give cmd.exe superpowers|
|uutils-coreutils|gnu commands|
|sharex|take screenshots|

#### Linux only

|Package|Purpose|
|-|-|
|i3-wm|tiling window manager|
|dmenu|program runner|
|xorg-xinit|x session starter script|
|xorg-server|x server to run i3|
|noto-fonts-emoji|render emojis|
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

</details>

### Quick Setup

<details>
<summary>
  Linux
</summary>



Installation command for packages

```bash
sudo pacman -S --noconfirm i3-wm dmenu xorg-xinit xorg-server pulseaudio trash-cli nodejs luajit ruby python pnpm luarocks dotnet-sdk julia duf bat dust fzf fd neovim ripgrep tgpt sd yazi zoxide hyperfine yq wezterm firefox git gron eza procs curlie zsh zsh-syntax-highlighting zsh-autosuggestions xclip brightnessctl noto-fonts-emoji flameshot ttf-jetbrains-mono-nerd onefetch
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
mkdir -p ~/.config/i3 && ln -s ~/dotfiles/i3.sh ~/.config/i3/config && echo "source ~/dotfiles/zsh.zsh" > ~/.zshrc
```

</details>

<details>

<summary>
Windows
</summary>

Install scoop (in my experience this is the best package manager for windows)

```ps
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser; Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

Add buckets and install packages

```ps
scoop bucket add extras ; scoop bucket add nerd-fonts ; scoop install bat clink duf dust eza fd firefox fzf git gron JetBrainsMono-NF jq luajit neovim nodejs pnpm ripgrep sd wezterm yazi zoxide yq curlie hyperfine procs uutils-coreutils luarocks ruby tgpt julia dotnet-sdk gimp flameshot
```

---

Windows comes in with hundreds of packages I don't use and that slow down my computer. That's why I use the script below ([win11debloat](https://github.com/Raphire/Win11Debloat)) which removes all those apps and if I ever need them back I can easily reinstall through the Microsoft Store

```powershell
& ([scriptblock]::Create((irm "https://win11debloat.raphi.re/")))
```

---

In my `wezterm.lua` I set the env variables for all other apps, but the below command is required so that that config file can be loaded in the first place. It permanently sets the environment variable in the system

```powershell
setx WEZTERM_CONFIG_FILE "%USERPROFILE%\dotfiles\wezterm.lua"
setx GLAZEWM_CONFIG_PATH "%USERPROFILE%\dotfiles\glazewm.yaml"
```

---

This single command will generate Git SSH keys and copy them into clipboard so I can easily setup Git and GitHub on a new computer in just 2 seconds

```powershell
New-Item -ItemType Directory -Path $env:USERPROFILE\.ssh -Force; ssh-keygen -t ed25519 -f "$env:USERPROFILE\.ssh\id_ed25519" -N '""' ; type "$env:USERPROFILE\.ssh\id_ed25519.pub" | clip
```

---

Now just clone this repo into `~/dotfiles` (it needs to be there since all the env variables in `wezterm.lua` point to that place) and launch wezterm

```powershell
git clone https://github.com/nikitarevenco/dotfiles %USERPROFILE%\dotfiles
```

</details>
