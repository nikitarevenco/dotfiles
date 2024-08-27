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
scoop install 7zip autohotkey bat clink diff-so-fancy duf eza fzf git gron lazygit neovim nodejs lua make pnpm python s sd go sharex wezterm zoxide nomino
```

| Package                                                    | Description                                                                                               |
| ---------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| [7zip](https://www.7-zip.org/)                             | A multi-format file archiver with high compression ratios                                                 |
| -                                                          | -                                                                                                         |
| [autohotkey](https://www.autohotkey.com/)                  | The ultimate automation scripting language for Windows.                                                   |
| -                                                          | -                                                                                                         |
| [bat](https://github.com/sharkdp/bat)                      | A cat(1) clone with syntax highlighting and Git integration                                               |
| -                                                          | -                                                                                                         |
| [clink](https://chrisant996.github.io/clink/)              | Powerful Bash-style command line editing for cmd.exe                                                      |
| -                                                          | -                                                                                                         |
| [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy) | Make diffs human readable instead of machine readable to improve code quality and spot                    |
| defects faster.                                            |
| -                                                          | -                                                                                                         |
| [duf](https://github.com/muesli/duf)                       | Disk Usage/Free Utility - a better 'df' alternative                                                       |
| -                                                          | -                                                                                                         |
| [eza](https://github.com/eza-community/eza)                | A modern, maintained replacement for ls, built on exa.                                                    |
| -                                                          | -                                                                                                         |
| [fzf](https://github.com/junegunn/fzf)                     | A general-purpose command-line fuzzy finder                                                               |
| -                                                          | -                                                                                                         |
| [git](https://gitforwindows.org)                           | Distributed version control system                                                                        |
| -                                                          | -                                                                                                         |
| [gron](https://github.com/tomnomnom/gron)                  | Transform JSON into discrete assignments to make it easier to grep and see the absolute 'path'.           |
| -                                                          | -                                                                                                         |
| [lazygit](https://github.com/jesseduffield/lazygit)        | A simple terminal UI for git commands                                                                     |
| -                                                          | -                                                                                                         |
| [neovim](https://neovim.io/)                               | Vim-fork focused on extensibility and usability                                                           |
| -                                                          | -                                                                                                         |
| [nodejs](https://nodejs.org)                               | An asynchronous event driven JavaScript runtime designed to build scalable network applications.          |
| -                                                          | -                                                                                                         |
| [lua](https://www.lua.org)                                 | A powerful, efficient, lightweight, embeddable scripting language                                         |
| -                                                          | -                                                                                                         |
| [make](https://www.gnu.org/software/make/)                 | Build automation tool.                                                                                    |
| -                                                          | -                                                                                                         |
| [pnpm](https://pnpm.io/)                                   | A fast and disk space efficient Node package manager.                                                     |
| -                                                          | -                                                                                                         |
| [python](https://www.python.org/)                          | A programming language that lets you work quickly and integrate systems more effectively.                 |
| -                                                          | -                                                                                                         |
| [s](https://github.com/zquestz/s)                          | Open a web search in your terminal.                                                                       |
| -                                                          | -                                                                                                         |
| [sd](https://github.com/chmln/sd)                          | Intuitive find & replace CLI (sed alternative)                                                            |
| -                                                          | -                                                                                                         |
| [go](https://golang.org)                                   | An open source programming language that makes it easy to build simple, reliable, and efficient software. |
| -                                                          | -                                                                                                         |
| [sharex](https://getsharex.com/)                           | Screen capture, file sharing and productivity tool.                                                       |
| -                                                          | -                                                                                                         |
| [wezterm](https://github.com/wez/wezterm)                  | GPU-accelerated terminal emulator                                                                         |
| -                                                          | -                                                                                                         |
| [zoxide](https://github.com/ajeetdsouza/zoxide)            | A faster way to navigate your filesystem                                                                  |
| -                                                          | -                                                                                                         |
| [nomino](https://github.com/yaa110/nomino)                 | Batch rename utility for developers                                                                       |
| -                                                          | -                                                                                                         |

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
