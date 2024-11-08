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
        yazi.enable = true;
        zoxide.enable = true;
        ripgrep.enable = true;
        fzf.enable = true;
        fd.enable = true;
      };
    };
    environment.systemPackages =
      with pkgs;
      [
        wezterm
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
