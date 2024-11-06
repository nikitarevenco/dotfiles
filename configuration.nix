{ pkgs, lib, ... }:

let
  u =
    import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz")
      { config.allowUnfree = true; };
  version = "24.05";
  user = "e";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${version}.tar.gz";
in
{
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  nixpkgs.config = {
    packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };
  };

  home-manager.backupFileExtension = "backup";
  home-manager.users.${user} = {
    xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;

    home = {
      stateVersion = version;
      pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
      };
    };
    services.flameshot.enable = true;

    xsession.windowManager.i3 = (import ./i3.nix);
    programs = {
      helix = (import ./helix.nix) {
        u = u;
        pkgs = pkgs;
        lib = lib;
      };
      firefox = (import ./firefox.nix) {
        pkgs = pkgs;
        lib = lib;
      };
      git = (import ./git.nix);
      lazygit = (import ./lazygit.nix);
      bat = (import ./bat.nix) { pkgs = pkgs; };
      zsh = (import ./zsh.nix) { pkgs = pkgs; };
      wezterm.enable = true;
      zoxide.enable = true;
      ripgrep.enable = true;
      fzf.enable = true;
      fd.enable = true;
    };
  };

  environment = {
    # enable completion for system packages
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      sof-firmware
      xclip
      trash-cli
      p7zip
      brightnessctl

      # language servers
      u.typescript-language-server
      u.vscode-langservers-extracted
      u.bash-language-server
      u.rust-analyzer
      u.lua-language-server
      u.vue-language-server
      u.svelte-language-server
      u.yaml-language-server
      u.taplo
      u.dockerfile-language-server-nodejs
      u.nil
      u.marksman

      # formatters
      u.prettierd
      u.nixfmt-rfc-style

      # package managers
      u.pnpm
      u.cargo

      # compilers
      u.rustc
      u.gcc
    ];
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono NF" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
        emoji = [ "Noto Emoji" ];
      };
    };
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  programs.zsh.enable = true;
  security.sudo.wheelNeedsPassword = false;

  users = {
    defaultUserShell = pkgs.zsh;
    users.${user} = {
      initialPassword = user;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    tcp.enable = true;
  };

  networking = {
    hostName = "nixos";
    firewall.enable = true;
    wireless.enable = true;
  };

  services = {
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      windowManager.i3 = {
        enable = true;
      };
      autoRepeatDelay = 200;
      autoRepeatInterval = 25;
      xkb.layout = "us";
    };

    libinput.enable = true;

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

  };

  fileSystems."/".options = [
    "noatime"
    "nodiratime"
    "discard"
  ];

  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  boot = {
    kernelParams = [
      "intel_pstate=no_hwp"
      "quiet"
      "splash"
    ];
    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
    initrd.luks.devices.cryptroot.device = "/dev/disk/by-partlabel/luks_root";
  };

  system.stateVersion = version;
}
