{ pkgs }:
{
  enable = true;
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
}
