#!/bin/sh

alias e="eza --icons --git-ignore --sort=changed --across --classify"
alias ea="eza --icons --sort=changed --across --classify --all"

alias er="e --recurse --level=2"
alias era="ea --recurse --level=2"

alias err="e --recurse --level=3"
alias erra="ea --recurse --level=3"

alias errr="e --recurse"
alias errra="ea --recurse"

alias ee="eza --icons --git-ignore --sort=changed --across --classify --long --total-size --no-user --no-permissions --git --time-style=relative --git-repos"
alias eea="eza --icons --sort=changed --across --classify --long --total-size --no-user --no-permissions --git --time-style=relative --git-repos --all"

alias eer="ee --recurse --level=2"
alias eera="eea --recurse --level=2"

alias eerr="ee --recurse --level=3"
alias eerra="eea --recurse --level=3"

alias eerrr="ee --recurse"
alias eerrra="eea --recurse"

alias eee="eza --icons --git-ignore --sort=changed --across --classify --long --total-size --git --time-style=relative --git-repos --octal-permissions --extended --blocksize --mounts --inode --header --group"
alias eeea="eza --icons --sort=changed --across --classify --long --total-size --git --time-style=relative --git-repos --octal-permissions --extended --blocksize --mounts --inode --header --group --all"

alias eeer="eee --recurse --level=2"
alias eeera="eeea --recurse --level=2"

alias eeerr="eee --recurse --level=3"
alias eeerra="eeea --recurse --level=3"

alias eeerrr="eee --recurse"
alias eeerrra="eeea --recurse"
