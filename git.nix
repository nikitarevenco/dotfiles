{
  userName = "Nikita Revenco";
  userEmail = "154856872+nikitarevenco@users.noreply.github.com"; 
  extraConfig = {
    pull.rebase = true;
    init.defaultBranch = "main";
    safe.directory = "*";
  };
  delta.enable = true;
  enable = true;
  aliases = {
    "a" = "add";
    "c" = "commit";
    "P" = "push";
    "f" = "fetch";
    "p" = "pull";
    "l" = "log";
    "s" = "status";
  };
}
