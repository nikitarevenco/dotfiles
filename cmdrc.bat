@echo off

::
::
:: ALIASES
::
::

doskey norg=gron --ungron
doskey l=lazygit $*
doskey r=trash $*
doskey b=bat --style=plain --theme ansi $*
doskey g=git $*
doskey n=nvim -u %USERPROFILE%\dotfiles\neovim.lua $*
doskey ?=tldr --static $*
doskey dns=nslookup $*
doskey s=s -p google $*

::
:: ZOXIDE ALIASES
::

doskey z=zoxide query $*
doskey t=zoxide add $1 ^& cd /d $1 ^& eza --icons --git-ignore --sort=changed --across --classify

::
:: FAST TRAVEL ALIASES
::

doskey .=cd /d .. ^& eza --icons --git-ignore --sort=changed --across --classify
doskey ..=cd /d ..\.. ^& eza --icons --git-ignore --sort=changed --across --classify
doskey ...=cd /d ..\..\.. ^& eza --icons --git-ignore --sort=changed --across --classify
doskey ....=cd /d ..\..\..\.. ^& eza --icons --git-ignore --sort=changed --across --classify
doskey .....=cd /d ..\..\..\..\.. ^& eza --icons --git-ignore --sort=changed --across --classify

::
:: UNIX ALIASES
::

doskey cp=robocopy $*
doskey mv=move $*
doskey pwd=cd

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
