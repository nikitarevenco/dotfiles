{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    localVariables = {
      PROMPT = "%F{green} ➜ %f";
      RPROMPT = "%F{blue}%~ ";
    };
    initExtra = ''
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      alias -s .git="git clone"
      function t() {
        z "$1"
        ls
      }
    '';
    profileExtra = ''
      if [[ "$(tty)" = "/dev/tty1" ]]; then 
        pgrep i3 || startx $(which i3)
      fi
    '';
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
      "yank" = "xclip -selection clipboard";
      "r" = "trash";
      "n" = "hx";
      "e" = "ls --classify --human-readable";
      "g" = "git";
      "." = "cd .. && e";
      ".." = "cd ../.. && e";
      "..." = "cd ../../.. && e";
    };
  };
}
