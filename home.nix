{
  pkgs,
  config,
  pkgs-unstable,
  ...
}:
{
  imports = [
    ./helix.nix
    ./bat.nix
    ./firefox.nix
    ./git.nix
    ./lazygit.nix
    ./zsh.nix
    ./i3.nix
    ./languages.nix
  ];

  home.packages =
    with pkgs;
    [
      sof-firmware
      ripgrep
      xclip
      trash-cli
      p7zip
      brightnessctl
    ]
    ++ (with pkgs-unstable; [
      # for recordings
      gnome-terminal
      dconf
      asciinema
    ]);

  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
  xdg.userDirs.download = "${config.home.homeDirectory}/t";
  xsession.windowManager.i3.enable = true;
  services.flameshot.enable = true;
  programs = {
    yazi.enable = true;
    zoxide.enable = true;
    wezterm.enable = true;
    ripgrep.enable = true;
    fzf.enable = true;
    fd.enable = true;
    go.enable = true;
    go.goBin = "go/bin";
  };
  home = {
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    stateVersion = "24.05";
  };
}
