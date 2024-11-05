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
    # nixpkgs.config.packageOverrides = pkgs: {
	   #  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
	   #    inherit pkgs;
	   #  };
    # };    
    xdg.configFile."wezterm/wezterm.lua".source = ./wezterm;
    xdg.configFile."i3/config".source = ./i3;
    home = {
      stateVersion = version;
      pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
      };
      shellAliases = {
        "md" = "mkdir";
        "r" = "trash";
        "g" = "git";
        "n" = "hx";
        "." = "cd .. && ls";
        ".." = "cd ../.. && ls";
        "..." = "cd ../../.. && ls";
      };
    };

    programs = {
      firefox = {
        enable = true;
        profiles.nikita = {
          # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          #   # https://github.com/TLATER/dotfiles/blob/b39af91fbd13d338559a05d69f56c5a97f8c905d/home-config/config/graphical-applications/firefox.nix            react-devtools
          #   ublock-origin
          #   clearurls
          #   stylus
          #   darkreader
          #   proton-pass
          #   sponsorblock
          # ];
          settings = {
            "app.update.auto" = false;
            "browser.discovery.enabled" = false;
            "browser.startup.homepage" = "about:blank";
            "general.smoothScroll" = true;
            "signon.rememberSignons" = false;
            "signon.autofillForms" = false;
            "widget.non-native-theme.scrollbar.style" = 3;
            "browser.uidensity" = 1;
            "browser.compactmode.show" = true;
            # disable full screen fade animation
            "full-screen-api.transition-duration.enter" = "0 0";
            "full-screen-api.transition-duration.leave" = "0 0";
            "full-screen-api.transition.timeout" = 0;
            "full-screen-api.warning.delay" = 0;
            "full-screen-api.warning.timeout" = 0;
          };
        };
      };
      helix = {
        enable = true;
      	settings = {
          theme = "catppuccin_mocha";
      	  editor = {
            line-number = "relative";
            auto-save = true;
            cursorline = true;
            statusline.left = [ "mode" "spinner" "version-control" "file-name" ];
            indent-guides = {
              character = "╎";
              render = true;
            };
            cursor-shape = {
              insert = "bar";
              select = "underline";
            };
      	  };
          keys.normal = {
            right = "goto_word";
            up = "select_textobject_inner";
            down = "select_textobject_around";
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
      sof-firmware
      wezterm
      bat
      ripgrep
      fzf
      zoxide
      eza
      xclip
      git
      fd
      flameshot
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
