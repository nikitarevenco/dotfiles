{
  config,
  pkgs,
  lib,
  ...
}:

let
  version = "24.05";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${version}.tar.gz";
in
{
  options.user = lib.mkOption {
    type = lib.types.str;
    default = "e";
  };

  imports = [
    ./hardware-configuration.nix
    ./helix.nix
    ./bat.nix
    ./firefox.nix
    ./git.nix
    ./lazygit.nix
    ./zsh.nix
    ./i3.nix
    (import "${home-manager}/nixos")
  ];

  config = {
    nixpkgs.config = {
      packageOverrides = pkgs: {
        unstable =
          import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz")
            { config.allowUnfree = true; };
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };
    };

    home-manager.backupFileExtension = "backup";
    home-manager.users.${config.user} = {
      xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;

      home = {
        stateVersion = version;
        pointerCursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
        };
      };
      services.flameshot.enable = true;

      programs = {
        yazi.enable = true;
        wezterm.enable = true;
        zoxide.enable = true;
        ripgrep.enable = true;
        fzf.enable = true;
        fd.enable = true;
      };
    };

    environment = {
      sessionVariables = {
        RUSTFLAGS = "-C linker=clang -C link-arg=-fuse-ld=${pkgs.mold}/bin/mold";
      };
      # enable completion for system packages
      pathsToLink = [ "/share/zsh" ];
      systemPackages = with pkgs; [
        sof-firmware
        xclip
        trash-cli
        p7zip
        brightnessctl
        mold
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
      users.${config.user} = {
        initialPassword = config.user;
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
  };
}
