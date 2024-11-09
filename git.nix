{ config, ... }:
{
  programs.git = {
    enable = true;
    userName = "Nikita Revenco";
    userEmail = "154856872+nikitarevenco@users.noreply.github.com";
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
      safe.directory = "*";
    };
    aliases = {
      "a" = "add";
      "c" = "commit";
      "co" = "checkout";
      "p" = "push";
      "r" = "remote";
      "b" = "branch";
      "f" = "fetch";
      "pl" = "pull";
      "l" = "log";
      "d" = "diff";
      "s" = "status";
    };
  };
}
