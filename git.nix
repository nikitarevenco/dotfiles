{
  programs.git = {
    userName = "Nikita Revenco";
    userEmail = "154856872+nikitarevenco@users.noreply.github.com"; 
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
    };
    delta.enable = true;
    enable = true;
    safe.directory = "*";
    aliases = {
      "a" = "add";
      "c" = "commit";
      "P" = "push";
      "f" = "fetch";
      "p" = "pull";
      "l" = "log";
      "s" = "status";
    };
  };
}
