# Nikita Revenco Windows 11 Dotfiles

My ideal windows 11 dev setup.

## Screenshots

![two firefox tabs](https://github.com/user-attachments/assets/7cd6c6db-758c-4dd1-ac09-7583d6f768f9)

![neovim setup](https://github.com/user-attachments/assets/7cd00475-b671-4658-a168-6bd11327ab45)

![terminal picture](https://github.com/user-attachments/assets/c55860f9-87c2-4b3e-9c2f-26e3d7c9448c)


---
 
win11debloat

```powershell
& ([scriptblock]::Create((irm "https://win11debloat.raphi.re/")))
```

scoop

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser; Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression ; scoop bucket add extras ; scoop bucket add nerd-fonts ; scoop install 7zip autohotkey bat clink deno diff-so-fancy duf dust eza fd firefox fzf git go grep gron imagemagick JetBrainsMono-NF jq lazygit lua make neovim nodejs nomino pnpm poppler python qbittorrent ripgrep s sd sharex wezterm yazi zig zoxide jid yq doggo gping
```

env variable

```powershell
setx WEZTERM_CONFIG_FILE "%USERPROFILE%\dotfiles\wezterm.lua"
```

github

```powershell
New-Item -ItemType Directory -Path $env:USERPROFILE\.ssh -Force; ssh-keygen -t ed25519 -f "$env:USERPROFILE\.ssh\id_ed25519" -N '""' ; type "$env:USERPROFILE\.ssh\id_ed25519.pub" | clip
```

clone repo

```powershell
git clone https://github.com/nikitarevenco/dotfiles %USERPROFILE%\dotfiles
```
