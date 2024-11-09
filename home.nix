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

      # package manager
      pnpm
      cargo

      mold
      nodejs
      clang
      rustc
      deno

      nodejs
    ]
    ++ (with pkgs-unstable; [
      # language servers
      typescript-language-server
      tailwindcss-language-server
      vscode-langservers-extracted
      bash-language-server
      rust-analyzer
      nil

      prettierd
      nixfmt-rfc-style
      stylua
      shfmt
      rustfmt
    ]);

  xdg.configFile."pnpm/rc".source =
    let
      keyValue = pkgs.formats.keyValue { };
    in
    keyValue.generate "rc" { update-notifier = false; };
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
  };
  home = {
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    stateVersion = "24.05";
  };
}
