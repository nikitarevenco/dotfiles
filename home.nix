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
    sessionPath = [
      "$HOME/.cache/npm/global/bin"
    ];
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    packages =
      with pkgs;
      [
        sof-firmware
        ripgrep
        libreoffice
        xclip
        # google-chrome
        trash-cli
        p7zip
        brightnessctl
        imagemagick
        # otherwise playwright will not work
        # chromium
      ]
      ++ (with pkgs-unstable; [
        # for recordings
        gnome-terminal
        playwright-test
        jq
        # playwright-driver
        dconf
        asciinema
        # interactive search and replace
        scooter
        # benchmarking tool
        hyperfine
      ]);
    stateVersion = "24.05";
  };
}
