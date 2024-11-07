{ config, ... }:
{
  home-manager.users.${config.user}.programs.git = {
    userName = "Nikita Revenco";
    userEmail = "154856872+nikitarevenco@users.noreply.github.com";
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
      safe.directory = "*";
    };
    enable = true;
    aliases = {
      "a" = "add";
      "c" = "commit";
      "e" = "checkout";
      "u" = "push";
      "r" = "remote";
      "b" = "branch";
      "f" = "fetch";
      "p" = "pull";
      "l" = "log";
      "d" = "diff";
      "s" = "status";
    };
  };
}
