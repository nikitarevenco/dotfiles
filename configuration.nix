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
    /etc/nixos/hardware-configuration.nix
    (import "${home-manager}/nixos") 
  ];

  home-manager.backupFileExtension = "backup";
  home-manager.users.e = {
    xdg.configFile."wezterm/wezterm.lua".source = ./wezterm;
    home = {
      stateVersion = version;
      pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
      };
    };
    programs = {
      helix = {
        enable = true;
      	settings = {
          theme = "catppuccin_mocha";
      	  editor = {
            line-number = "relative";
      	  };
          keys.normal = {
            # until https://github.com/helix-editor/helix/issues/1630 is closed
            g.l = [ "select_mode" "goto_line_end" "normal_mode" ];
            Right = [ "goto_word" ];
          };
      	};
      };
      bat.enable = true;
      zoxide.enable = true;
      wezterm = {
        enable = true;
      };
      zsh = {
        enable = true;
      	enableCompletion = true;
      	autosuggestion.enable = true;
      	syntaxHighlighting.enable = true;
      	localVariables = {
          PROMPT = "%F{green} ➜ %f";
      	  RPROMPT = "%F{blue}$(pwd | sed 's|$HOME|%F{magenta}~%F{blue}|;s|/|%F{white}/ %F{blue}|g')%f ";
      	};
    	  # ctrl-right and ctrl-left
      	initExtra = ''\
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word'';
    	  # start i3 when logging in
  	profileExtra = ''\
if [[ "$(tty)" = "/dev/tty1" ]]; then
  pgrep i3 || startx $(which i3)
fi'';
      };
    };
  };
  
  environment = {
    # enable completion for system packages
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      rustup
      sof-firmware
      wezterm
      bat
      ripgrep
      fzf
      zoxide
      eza
      xclip
      git
      unstable.neovim
      fd
      flameshot
      firefox
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
      windowManager.i3.enable = true;
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
