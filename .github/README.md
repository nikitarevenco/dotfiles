# Nikita Revenco Windows 11 Dotfiles

My ideal dev environment in Windows 11 with config files for:

- Neovim
- Wezterm
- GlazeWM
- LazyGit
- Command Prompt
- Clink
- Git

## Setup

### Download

Open PowerShell as an administrator.
Run the following command which downloads this repo's files into `dotfiles` directory within your home directory:

```powershell
Invoke-WebRequest -Uri "https://github.com/nikitarevenco/dotfiles/archive/refs/heads/main.zip" -OutFile "$env:USERPROFILE\dotfiles.zip"; Expand-Archive -Path "$env:USERPROFILE\dotfiles.zip" -DestinationPath "$env:USERPROFILE\dotfiles" -Force; Move-Item -Path "$env:USERPROFILE\dotfiles\dotfiles-main\*" -Destination "$env:USERPROFILE\dotfiles" -Force; Remove-Item "$env:USERPROFILE\dotfiles\dotfiles-main" -Recurse; Remove-Item "$env:USERPROFILE\dotfiles.zip"
```

### Package Installations

Run the following two commands to install `scoop` package manager:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

```powershell
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

Add scoop buckets:

```powershell
scoop bucket add extras nerd-fonts
```

Install the packages:

```powershell
scoop install 7zip autohotkey bat clink diff-so-fancy duf eza fzf git gron lazygit neovim nodejs lua make pnpm python s sd go sharex wezterm zoxide
```

```powershell
npm install --global trash-cli
```

### Env Variable

Set the following environment variable.

```powershell
setx WEZTERM_CONFIG_FILE "%USERPROFILE%\dotfiles\wezterm.lua"
```

### Git

Generate ssh keys:

```powershell
ssh-keygen -t ed25519
```

Copy the following output into `GitHub > Settings > SSH Keys > New SSH Key`

```powershell
type %USERPROFILE%\.ssh\id_ed25519.pub
```

Then test the connection:

```powershell
ssh -T git@github.com
```

### Debloating

Debloat Windows for increased privacy and better performance.

1. Open PowerShell as an administrator.
1. Run this script ([Win11Debloat](https://github.com/Raphire/Win11Debloat)) and choose the default settings:

```powershell
& ([scriptblock]::Create((irm "https://win11debloat.raphi.re/")))
```
