{ config, pkgs, ... }:
{
  home-manager.users.${config.user}.programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    localVariables = {
      PROMPT = "%F{green} ➜ %f";
      RPROMPT = "%~ ";
    };
    # ctrl-right and ctrl-left
    initExtra = ''
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word'';
    # start i3 when logging in
    profileExtra = ''
      if [[ "$(tty)" = "/dev/tty1" ]]; then 
        pgrep i3 || startx $(which i3)
      fi'';
    plugins = [
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.zsh";
      }
    ];
    shellAliases = {
      "md" = "mkdir";
      "cat" = "bat";
      "copy" = "xclip -selection clipboard";
      "r" = "trash";
      "n" = "hx";
      "e" = "ls --classify --human-readable";
      "ee" = "e --almost-all";
      "t" = "z && e";
      "g" = "git";
      "." = "cd .. && e";
      ".." = "cd ../.. && e";
      "..." = "cd ../../.. && e";
    };
  };
}
