@echo off

::
::
:: ALIASES
::
::

doskey l=lazygit $*
doskey js=node -e "console.log($*)"
doskey norg=gron --ungron
doskey b=bat --style=plain --theme ansi $*
doskey g=git $*
doskey n=nvim -u %USERPROFILE%\dotfiles\neovim.lua $*
doskey s=s -p google $*
doskey zip=7z a -t7z $*
doskey ps=powershell -ExecutionPolicy Bypass -File $1
doskey dus=dust -bX .git
doskey r=powershell -command "& {param($args) %USERPROFILE%\dotfiles\scripts\trash.ps1 $args}" $*
doskey mit=curl -s https://raw.githubusercontent.com/nikitarevenco/github-template/main/LICENSE ^> LICENSE

::
:: I LIKE THESE NAMES MORE
::

doskey dns=doggo $*
doskey fetch=curlie $*
doskey bench=hyperfine $*

::
:: PNPM ALIASES
::

doskey p=pnpm $*
doskey pi=pnpm add $*
doskey pid=pnpm add -D $*
doskey px=pnpm dlx $*
doskey po=pnpm outdated $*
doskey pu=pnpm update $*
doskey pl=pnpm list $*

::
:: ZOXIDE ALIASES
::

REM doskey t=z $* ^& eza --icons --git-ignore --sort=changed --across --classify
REM doskey t=zoxide add $1 ^& cd /d $1 ^& eza --icons --git-ignore --sort=changed --across --classify
REM doskey z=for /f "delims=" %d in ('zoxide query $*') do @cd "%d" ^& eza --icons --git-ignore --sort=changed --across --classify

::
:: FAST TRAVEL ALIASES
::

doskey .=cd /d .. ^& eza --icons --git-ignore --sort=changed --across --classify
doskey ..=cd /d ..\.. ^& eza --icons --git-ignore --sort=changed --across --classify
doskey ...=cd /d ..\..\.. ^& eza --icons --git-ignore --sort=changed --across --classify
doskey ....=cd /d ..\..\..\.. ^& eza --icons --git-ignore --sort=changed --across --classify
doskey .....=cd /d ..\..\..\..\.. ^& eza --icons --git-ignore --sort=changed --across --classify

::
:: EZA ALIASES
::

doskey e=eza --icons --git-ignore --sort=changed --across --classify $*
doskey ea=eza --icons --sort=changed --across --classify --all $*

doskey er=eza --icons --git-ignore --sort=changed --across --classify --recurse --level=2 $*
doskey era=eza --icons --sort=changed --across --classify --all --recurse --level=2 $*

doskey err=eza --icons --git-ignore --sort=changed --across --classify --recurse --level=3 $*
doskey erra=eza --icons --sort=changed --across --classify --all --recurse --level=3 $*

doskey errr=eza --icons --git-ignore --sort=changed --across --classify --recurse $*
doskey errra=eza --icons --sort=changed --across --classify --all --recurse $*

doskey ee=eza --icons --git-ignore --sort=changed --across --classify --long --total-size --no-user --no-permissions --git --time-style=relative --git-repos $*
doskey eea=eza --icons --sort=changed --across --classify --long --total-size --no-user --no-permissions --git --time-style=relative --git-repos --all $*

doskey eer=eza --icons --git-ignore --sort=changed --across --classify --long --total-size --no-user --no-permissions --git --time-style=relative --git-repos --recurse --level=2 $*
doskey eera=eza --icons --sort=changed --across --classify --long --total-size --no-user --no-permissions --git --time-style=relative --git-repos --all --recurse --level=2 $*

doskey eerr=eza --icons --git-ignore --sort=changed --across --classify --long --total-size --no-user --no-permissions --git --time-style=relative --git-repos --recurse --level=3 $*
doskey eerra=eza --icons --sort=changed --across --classify --long --total-size --no-user --no-permissions --git --time-style=relative --git-repos --all --recurse --level=3 $*

doskey eerrr=eza --icons --git-ignore --sort=changed --across --classify --long --total-size --no-user --no-permissions --git --time-style=relative --git-repos --recurse $*
doskey eeerrra=eza --icons --sort=changed --across --classify --long --total-size --no-user --no-permissions --git --time-style=relative --git-repos --all --recurse $*

doskey eee=eza --icons --git-ignore --sort=changed --across --classify --long --total-size --git --time-style=relative --git-repos --octal-permissions --extended --blocksize --mounts --inode --header --group $*
doskey eeea=eza --icons --sort=changed --across --classify --long --total-size --git --time-style=relative --git-repos --octal-permissions --extended --blocksize --mounts --inode --header --group --all $*

doskey eeer=eza --icons --git-ignore --sort=changed --across --classify --long --total-size --git --time-style=relative --git-repos --octal-permissions --extended --blocksize --mounts --inode --header --group --recurse --level=2 $*
doskey eeera=eza --icons --sort=changed --across --classify --long --total-size --git --time-style=relative --git-repos --octal-permissions --extended --blocksize --mounts --inode --header --group --all --recurse --level=2 $*

doskey eeerr=eza --icons --git-ignore --sort=changed --across --classify --long --total-size --git --time-style=relative --git-repos --octal-permissions --extended --blocksize --mounts --inode --header --group --recurse --level=3 $*
doskey eeerra=eza --icons --sort=changed --across --classify --long --total-size --git --time-style=relative --git-repos --octal-permissions --extended --blocksize --mounts --inode --header --group --all --recurse --level=3 $*

doskey eeerrr=eza --icons --git-ignore --sort=changed --across --classify --long --total-size --git --time-style=relative --git-repos --octal-permissions --extended --blocksize --mounts --inode --header --group --recurse $*
doskey eeerrra=eza --icons --sort=changed --across --classify --long --total-size --git --time-style=relative --git-repos --octal-permissions --extended --blocksize --mounts --inode --header --group --all --recurse $*
