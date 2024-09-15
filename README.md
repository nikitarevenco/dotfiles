## Nikita Revenco Windows 11 Dotfiles

My ideal windows 11 dev setup! 💖🪟😃

- [Overview](#overview)
- [Common commands](#common-commands-i-use)
- [Quick setup](#quick-setup)

### Overview

![preview image](https://github.com/user-attachments/assets/eb71f763-1449-4232-8521-da587793c09a)

- Tiling Window Manager -> [GlazeWM](https://github.com/glzr-io/glazewm)
- Neovim
- Wezterm
- [Clink](https://github.com/chrisant996/clink) -> Turns cmd.exe into a powerhouse of a shell. All the features of powershell and the speed of zsh
- A _Lot_ of CLI tools (grep, sd, yazi, fzf, zoxide, and dozens of others)

These dotfiles are unlike most others, as you can see I prefer to use 1 config file per app (see `neovim.lua`, `wezterm.lua`, etc.) as opposed to "organizing" them into folders with subdirectories and dozens of smaller files like I'd do with a project

This is possible because all of the apps allow custom configuration path to be passed. I prefer having my configs in `~/dotfiles` (aka `%USERPROFILE%\dotfiles`) as opposed to `.config`. I think it's awesome having everything I need in one place

### Common commands I use

- `t` and `ti`: zoxide which is a superior alternative to the `cd` command

![ti command being used](https://github.com/user-attachments/assets/01eb38e4-b14e-4dd3-ac28-098f4da11165)

- `e`: Eza which is like `ls` but with icons and color

![e command being used](https://github.com/user-attachments/assets/f5d79c60-b839-4395-ac5c-3df3fb03092e)

- `w`: spawns a wezterm window with working directory same as current
- `n`: open `nvim`
- `r`: sends all of its arguments to the trash
- `i`: runs a one-off command in a folder without `cd`ing into it

You can find most others in the [`doskeys.cmd`](https://github.com/nikitarevenco/dotfiles/blob/main/doskeys.cmd) file (doskeys are like `alias` in bash). For more complicated commands, they can be found in the `scripts/` folder (e.g. the `t` command which is in `t.lua` as we have to use clink to integrate zoxide with cmd.exe since zoxide does not provide official support).

Scripts starting with `_` do not correspond to any command in particular but rather change behaviour of the terminal (e.g. highlight environmental variables)

### Packages

I usually forget why I install certain stuff so I keep note of all the packages in this table.

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
|fd|better `find`|
|neovim|editor|
|ripgrep|better `grep`|
|s|search internet|
|tgpt|ai prompt|
|sd|better `sed`|
|yazi|file manager|
|zoxide|better `cd`|
|doggo|dns client|
|hyperfine|benchmarking tool|
|yq|yaml,json processor|
|jid|json digger|
|wezterm|terminal emulator|
|firefox|browser|
|JetBrainsMono NF|monospace font|
|git|version control|
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

Install scoop

```ps
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser; Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

Add buckets and install packages

```ps
scoop bucket add extras ; scoop bucket add nerd-fonts ; scoop install bat clink duf dust eza fd firefox fzf git gron JetBrainsMono-NF jq luajit neovim nodejs pnpm ripgrep s sd wezterm yazi zoxide jid yq doggo curlie hyperfine procs uutils-coreutils luarocks ruby tgpt julia dotnet-sdk
```

Installation command

```
scoop install
```

#### Linux only

|Package|Purpose|
|-|-|
|bspwm|tiling window manager|
|sxhkd|shortcut daemon|
|xorg-xinit|x session starter|
|alsa-utils|to make Volume {Up,Down,Toggle} keys work|
|trash-cli|like `rm` but we can recover|

Installation command

```bash
sudo pacman -S bspwm sxhkd xorg-xinit alsa-utils trash-cli nodejs luajit ruby python pnpm luarocks dotnet-sdk julia duf bat dust fzf fd neovim ripgrep s tgpt sd yazi zoxide doggo hyperfine yq jid wezterm firefox git gron eza procs curlie
```

### Quick Setup

<details>
<summary>
  Linux
</summary>

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
mkdir -p ~/.config/bspwm ~/.config/sxhkd && ln -s ~/dotfiles/bspwm.sh ~/.config/bspwm/bspwmrc && ln -s ~/dotfiles/sxhkd.sh ~/.config/sxhkd/sxhkdrc && ln -s ~/dotfiles/.zshrc ~/.zshrc
```

</details>

<details>

<summary>
Windows
</summary>

Windows comes in with hundreds of packages I don't use and that slow down my computer. That's why I use the script below ([win11debloat](https://github.com/Raphire/Win11Debloat)) which removes all those apps and if I ever need them back I can easily reinstall through the Microsoft Store

```powershell
& ([scriptblock]::Create((irm "https://win11debloat.raphi.re/")))
```

---

In my `wezterm.lua` I set the env variables for all other apps, but the below command is required so that that config file can be loaded in the first place. It permanently sets the environment variable in the system

```powershell
setx WEZTERM_CONFIG_FILE "%USERPROFILE%\dotfiles\wezterm.lua"
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
