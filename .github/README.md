# Nikita Revenco Windows 11 Dotfiles

My personal ideal dev environment in Windows 11 including:

- Neovim
- Wezterm
- GlazeWM
- LazyGit
- Clink
- Command Prompt
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
scoop install neovim nodejs pnpm git nerd-fonts/JetBrains-Mono wezterm glazewm whkd main/clink starship lua lazygit bat tldr fzf duf sd gron
```

```powershell
npm install --global trash-cli
```

### Clink Setup

Enhance `cmd.exe` which is used by wezterm with extra features which make it fancy like the other terminals.

1. Open the Registry Editor.
1. Go to `HKEY_CURRENT_USER > Software > Microsoft > Command Processor`.
1. Add a new entry for `AutoRun` with the following value:

```powershell
"C:\%USERPROFILE%\scoop\apps\clink\current\clink.bat" inject --autorun & "C:\%USERPROFILE%\dotfiles\cmdrc.bat"
```

### Env Variable

Set the following environment variable.

1. Open quick start menu.
1. Open `"Edit environment variables for your account"`.
1. Under `Environment Variables > User Variables` click on `New` to add additional variables.
1. For the `PATH` variable, click `Edit` and then `Add` the respective value.

| Name                | Value                                |
| ------------------- | ------------------------------------ |
| WEZTERM_CONFIG_FILE | `%USERPROFILE%\dotfiles\wezterm.lua` |

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
