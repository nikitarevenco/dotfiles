# Nikita Revenco Windows 11 Dotfiles

My ideal windows 11 dev setup

> [!WARNING]
> Use at your own risk

win11debloat

```powershell
& ([scriptblock]::Create((irm "https://win11debloat.raphi.re/")))
```

scoop

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser; Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression ; scoop bucket add extras ; scoop bucket add nerd-fonts ; scoop install 7zip autohotkey bat clink deno diff-so-fancy duf dust eza firefox fzf git go gron jq lazygit lua make neovim nodejs nomino pnpm python restic rustup s sd sharex wezterm yazi zig zoxide JetBrainsMono-NF
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
