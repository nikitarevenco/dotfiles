{
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  localVariables = {
    PROMPT = "%F{green} ➜ %f";
    RPROMPT = "%F{blue}$(pwd | sed 's|$HOME|%F{magenta}~%F{blue}|;s|/|%F{white}/ %F{blue}|g')%f ";

  };
  # ctrl-right and ctrl-left
  initExtra = ''
    \
    bindkey "^[[1;5C" forward-word
    bindkey "^[[1;5D" backward-word'';
  # start i3 when logging in
  profileExtra = ''
    \
     if [[ "$(tty)" = "/dev/tty1" ]]; then 
       pgrep i3 || startx $(which i3)
     fi'';
  shellAliases = {
    "md" = "mkdir";
    "r" = "trash";
    "e" = "ls --classify --human-readable";
    "ee" = "e --almost-all";
    "t" = "z && e";
    "g" = "git";
    "n" = "hx";
    "." = "cd .. && e";
    ".." = "cd ../.. && e";
    "..." = "cd ../../.. && e";
  };
}
