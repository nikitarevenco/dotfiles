{ config, lib, pkgs, ... }:

let
  unstable = import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
    config.allowUnfree = true;
  };
  version = "24.05";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${version}.tar.gz";
in
{
  imports = [ 
    ./hardware-configuration.nix
    (import "${home-manager}/nixos") 
  ];

  home-manager.backupFileExtension = "backup";
  home-manager.users.e = {
    xdg.configFile."i3/config".source = ./i3;
    xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
  
    home = {
      stateVersion = version;
      pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
      };
    };

    programs = {
      helix = (import ./helix.nix);
      firefox = (import ./firefox.nix);
      git = (import ./git.nix);
      zsh = (import ./zsh.nix);
      wezterm.enable = true;
      bat.enable = true;
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
      flameshot
      xclip
      trash-cli
      p7zip
      brightnessctl
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
    users.e = {
      initialPassword = "e";
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
  
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  boot = {
    kernelParams = [ "intel_pstate=no_hwp" "quiet" "splash" ];
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
