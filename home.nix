{ pkgs, inputs, ... }:
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
    xclip
    trash-cli
    p7zip
    brightnessctl
    mold
    clang

    # typescript-language-server
    # inputs.pkgs-unstable.vscode-langservers-extracted
    # bash-language-server
    # rust-analyzer
    # lua-language-server
    # yaml-language-server
    # nil

    # formatters
    # prettierd
    nixfmt-rfc-style
    # stylua
    # deno
    # shfmt
    rustfmt

    # package managers
    pnpm
    cargo

    # compilers
    rustc
    gcc
  ];

  # pointerCursor = {
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Modern-Ice";
  # };

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

  home.stateVersion = "24.05";
}
