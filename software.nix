{
  config,
  pkgs,
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
  config = {
    home-manager.users.${config.user} = {
      xsession.windowManager.i3.enable = true;
      services.flameshot.enable = true;
      programs = {
        git.enable = true;
        zsh.enable = true;
        i3.enable = true;
        yazi.enable = true;
        wezterm.enable = true;
        bat.enable = true;
        lazygit.enable = true;
        firefox.enable = true;
        helix.enable = true;
        zoxide.enable = true;
        ripgrep.enable = true;
        fd.enable = true;
      };
    };
    # required to be able to set zsh as default shell for users
    programs.zsh.enable = true;
    environment.systemPackages =
      with pkgs;
      [
        sof-firmware
        xclip
        trash-cli
        p7zip
        brightnessctl
        mold
        clang
      ]
      ++ (with pkgs.unstable; [
        typescript-language-server
        vscode-langservers-extracted
        bash-language-server
        rust-analyzer
        lua-language-server
        yaml-language-server
        nil

        # formatters
        prettierd
        nixfmt-rfc-style
        stylua
        deno
        shfmt
        rustfmt

        # package managers
        pnpm
        cargo

        # compilers
        rustc
        gcc
      ]);
  };
}
