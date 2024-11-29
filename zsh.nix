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
      function t() {
        z "$@" && ls
      }

      # Ctrl-Left and Ctrl-Right go to previous and next word
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      # Allow Ctrl-z to toggle between suspend and resume
      function Resume {
        fg
        zle push-input
        BUFFER=""
        zle accept-line
      }
      zle -N Resume
      bindkey "^Z" Resume
    '';
    profileExtra = ''
      # auto start i3 when logging in
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
      "rd" = "rmdir";
      "copy" = "xclip -selection clipboard";
      "r" = "trash";
      "n" = "hx";
      "e" = "ls --classify --human-readable";
      "g" = "git";
      "." = "cd .. && e";
      ".." = "cd ../.. && e";
      "..." = "cd ../../.. && e";
      "cat" = "bat --style=plain";
      "icat" = "wezterm imgcat";
      "head" = "bat --style=plain --line-range :10";
    };
  };
}
