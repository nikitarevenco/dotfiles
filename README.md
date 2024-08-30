# Nikita Revenco Windows 11 Dotfiles

- [Overview](#overview)
- [Common commands](#common-commands-that-i-use)
- [Quick setup](#quick-setup)

### Overview

![preview image](https://github.com/user-attachments/assets/430ec915-b828-433b-9d9b-cbe1c33f562a)

My ideal windows 11 dev setup! 💖🪟😃

- Tiling Window Manager -> [GlazeWM](https://github.com/glzr-io/glazewm)
- Neovim
- Wezterm
- [Clink](https://github.com/chrisant996/clink) -> Turns cmd.exe into a powerhouse of a shell. All the features of powershell and the speed of zsh
- A *Lot* of CLI tools (grep, sd, yazi, fzf, zoxide, and dozens of others)

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

### Quick Setup
 
Windows comes in with hundreds of packages I don't use and that slow down my computer. That's why I use the script below ([win11debloat](https://github.com/Raphire/Win11Debloat)) which removes all those apps and if I ever need them back I can easily reinstall through the Microsoft Store

```powershell
& ([scriptblock]::Create((irm "https://win11debloat.raphi.re/")))
```

---

I use scoop package manager which is my favorite one I've tried. Here's the command that will automatically install Scoop and every single package that I use

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser; Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression ; scoop bucket add extras ; scoop bucket add nerd-fonts ; scoop install 7zip autohotkey bat clink deno diff-so-fancy duf dust eza fd firefox fzf git go grep gron imagemagick JetBrainsMono-NF jq lazygit lua make neovim nodejs nomino pnpm poppler python qbittorrent ripgrep s sd sharex wezterm yazi zig zoxide jid yq doggo gping
```

---

In my `wezterm.lua` I set the env variables for all other apps like `lazygit`, but the below command is required so that that config file can be loaded in the first place. It permanently sets the environment variable in the system

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

---
