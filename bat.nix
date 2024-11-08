{ config, pkgs, ... }:
{
  home-manager.users.${config.user}.programs.bat = {
    package = pkgs.unstable.bat;
    config = {
      theme = "catppuccin-mocha";
      pager = "less -FR";
    };
    themes = {
      catppuccin-mocha = {
        src = pkgs.nur.repos.ryan4yin.catppuccin-bat;
        file = "Catppuccin-mocha.tmTheme";
      };
    };
  };
}
