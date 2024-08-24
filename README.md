# Nikita Revenco Windows 11 Dotfiles

My personal ideal dev environment in Windows 11 including:

- GlazeWM
- Wezterm
- Neovim
- Starship

## Setup

### Download

1. Open PowerShell as an administrator.
1. Run the following command which downloads this repo's files into `dotfiles` directory within your home directory:

```powershell
Invoke-WebRequest -Uri "https://github.com/nikitarevenco/dotfiles-windows/archive/refs/heads/main.zip" -OutFile "$env:USERPROFILE\dotfiles-windows.zip"; Expand-Archive -Path "$env:USERPROFILE\dotfiles-windows.zip" -DestinationPath "$env:USERPROFILE\dotfiles" -Force; Move-Item -Path "$env:USERPROFILE\dotfiles\dotfiles-windows-main\*" -Destination "$env:USERPROFILE\dotfiles" -Force; Remove-Item "$env:USERPROFILE\dotfiles\dotfiles-windows-main" -Recurse; Remove-Item "$env:USERPROFILE\dotfiles-windows.zip"
```

### Package Installations

1. Open PowerShell as an administrator.
1. Run the following two commands to install `scoop` package manager:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

```powershell
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

1. Add scoop buckets:

```powershell
scoop bucket add extras nerd-fonts
```

1. Install the packages:

```powershell
scoop install neovim nodejs pnpm git nerd-fonts/JetBrains-Mono wezterm glazewm whkd main/clink starship lua
```

### Clink Setup

Enhance `cmd.exe` which is used by wezterm with extra features which make it fancy like the other terminals.

1. Open the Registry Editor.
1. Go to `HKEY_CURRENT_USER > Software > Microsoft > Command Processor`.
1. Add a new entry for `AutoRun` with the following value:

```powershell
"C:\%USERPROFILE%\scoop\apps\clink\current\clink.bat" inject --autorun & "C:\%USERPROFILE%\dotfiles\cmdrc.bat"
```

### Env Variables

Set the following environment variables.

1. Open quick start menu.
1. Open `"Edit environment variables for your account"`.
1. Under `Environment Variables > User Variables` click on `New` to add additional variables.
1. For the `PATH` variable, click `Edit` and then `Add` the respective value.

| Name                | Value                                  |
| ------------------- | -------------------------------------- |
| PATH                | `%USERPROFILE%\AppData\Local\clink`    |
| PATH                | `%USERPROFILE%\dotfiles\scripts`       |
| CLINK_PATH          | `%USERPROFILE%\dotfiles\scripts`       |
| WEZTERM_CONFIG_FILE | `%USERPROFILE%\dotfiles\wezterm.lua`   |
| STARSHIP_CONFIG     | `%USERPROFILE%\dotfiles\starship.toml` |
| GIT_CONFIG_GLOBAL   | `%USERPROFILE%\dotfiles\git.ini`       |

### Git

1. Open wezterm.
1. Generate ssh keys:

```powershell
ssh-keygen -t ed25519
```

1. Copy the following output into `GitHub > Settings > SSH Keys > New SSH Key`

```powershell
type %USERPROFILE%\.ssh\id_ed25519.pub
```

1. Then test the connection:

```powershell
ssh -T git@github.com
```

### Debloating

Debloat Windows for increased privacy and better performance.

1. Open PowerShell as an administrator.
1. Run this script ([Win11Debloat](https://github.com/Raphire/Win11Debloat)):

```powershell
& ([scriptblock]::Create((irm "https://win11debloat.raphi.re/")))
```

1. Choose the default settings.
