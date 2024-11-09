{
  pkgs,
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

  home.packages = with pkgs; [
    sof-firmware
    ripgrep
    xclip
    trash-cli
    p7zip
    brightnessctl

    mold
    clang
    rustc

    pnpm
    cargo
    pkgs-unstable.typescript-language-server
    pkgs-unstable.vscode-langservers-extracted
    pkgs-unstable.bash-language-server
    pkgs-unstable.rust-analyzer
    pkgs-unstable.lua-language-server
    pkgs-unstable.yaml-language-server
    pkgs-unstable.nil

    # formatters
    pkgs-unstable.prettierd
    pkgs-unstable.nixfmt-rfc-style
    pkgs-unstable.stylua
    pkgs-unstable.deno
    pkgs-unstable.shfmt
    pkgs-unstable.rustfmt

  ];

  # home.packages = with pkgs; [
  # ];

  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
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
