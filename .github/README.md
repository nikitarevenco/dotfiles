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

### Debloating

Debloat Windows for increased privacy and better performance.

1. Open PowerShell as an administrator.
1. Run this script ([Win11Debloat](https://github.com/Raphire/Win11Debloat)) and choose the default settings:

```powershell
& ([scriptblock]::Create((irm "https://win11debloat.raphi.re/")))
```

### Package Installations

Run the following command to install `scoop` package manager and install all the packages:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser; Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression ; scoop bucket add extras ; scoop bucket add nerd-fonts ; scoop install 7zip autohotkey bat clink deno diff-so-fancy duf dust eza firefox fzf git go gron jq lazygit lua make neovim nodejs nomino pnpm python restic rustup s sd sharex wezterm yazi zig zoxide JetBrainsMono-NF
```

| Package                                                    | Description                                                                                               |
| ---------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| [7zip](https://www.7-zip.org/)                             | A multi-format file archiver with high compression ratios                                                 |
| [autohotkey](https://www.autohotkey.com/)                  | The ultimate automation scripting language for Windows.                                                   |
| [bat](https://github.com/sharkdp/bat)                      | A cat(1) clone with syntax highlighting and Git integration                                               |
| [clink](https://chrisant996.github.io/clink/)              | Powerful Bash-style command line editing for cmd.exe                                                      |
| [deno](https://deno.land)                                  | A secure runtime for JavaScript and TypeScript                                                            |
| [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy) | Make diffs human readable instead of machine readable to improve code quality and spot defects faster.    |
| [duf](https://github.com/muesli/duf)                       | Disk Usage/Free Utility - a better 'df' alternative                                                       |
| [dust](https://github.com/bootandy/dust)                   | du(1) - File space usage analyzer                                                                         |
| [eza](https://github.com/eza-community/eza)                | A modern, maintained replacement for ls, built on exa.                                                    |
| [firefox](https://www.mozilla.org/firefox/)                | Popular open source web browser.                                                                          |
| [fzf](https://github.com/junegunn/fzf)                     | A general-purpose command-line fuzzy finder                                                               |
| [git](https://gitforwindows.org)                           | Distributed version control system                                                                        |
| [go](https://golang.org)                                   | An open source programming language that makes it easy to build simple, reliable, and efficient software. |
| [gron](https://github.com/tomnomnom/gron)                  | Transform JSON into discrete assignments to make it easier to grep and see the absolute 'path'.           |
| [jq](https://jqlang.github.io/jq/)                         | Lightweight and flexible command-line JSON processor                                                      |
| [lazygit](https://github.com/jesseduffield/lazygit)        | A simple terminal UI for git commands                                                                     |
| [lua](https://www.lua.org)                                 | A powerful, efficient, lightweight, embeddable scripting language                                         |
| [make](https://www.gnu.org/software/make/)                 | Build automation tool.                                                                                    |
| [neovim](https://neovim.io/)                               | Vim-fork focused on extensibility and usability                                                           |
| [nodejs](https://nodejs.org)                               | An asynchronous event driven JavaScript runtime designed to build scalable network applications.          |
| [nomino](https://github.com/yaa110/nomino)                 | Batch rename utility for developers                                                                       |
| [pnpm](https://pnpm.io/)                                   | A fast and disk space efficient Node package manager.                                                     |
| [python](https://www.python.org/)                          | A programming language that lets you work quickly and integrate systems more effectively.                 |
| [restic](https://restic.net/)                              | Fast, secure and simple backup program.                                                                   |
| [rustup](https://rustup.rs)                                | Manage multiple rust installations with ease                                                              |
| [s](https://github.com/zquestz/s)                          | Open a web search in your terminal.                                                                       |
| [sd](https://github.com/chmln/sd)                          | Intuitive find & replace CLI (sed alternative)                                                            |
| [sharex](https://getsharex.com/)                           | Screen capture, file sharing and productivity tool.                                                       |
| [wezterm](https://github.com/wez/wezterm)                  | GPU-accelerated terminal emulator                                                                         |
| [yazi](https://github.com/sxyazi/yazi)                     | ?? Blazing fast terminal file manager written in Rust, based on async I/O.                                |
| [zig](https://ziglang.org/)                                | General-purpose programming language designed for robustness, optimality, and maintainability.            |
| [zoxide](https://github.com/ajeetdsouza/zoxide)            | A faster way to navigate your filesystem                                                                  |

### Env Variable

Set the following environment variable.

```powershell
setx WEZTERM_CONFIG_FILE "%USERPROFILE%\dotfiles\wezterm.lua"
```

### Git

Copy the following output into `GitHub > Settings > SSH Keys > New SSH Key`

```powershell
New-Item -ItemType Directory -Path $env:USERPROFILE\.ssh -Force; ssh-keygen -t ed25519 -f "$env:USERPROFILE\.ssh\id_ed25519" -N '""' ; type "$env:USERPROFILE\.ssh\id_ed25519.pub" | clip
```

### Download

Clone this repository

```powershell
git clone https://github.com/nikitarevenco/dotfiles %USERPROFILE%\dotfiles
```
