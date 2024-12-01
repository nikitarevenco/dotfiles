{ pkgs, pkgs-unstable, ... }:
let
  haskell = with pkgs-unstable; [
    haskell-language-server
    ormolu
    cabal-install
    ghc
  ];
  go = with pkgs-unstable; [
    gopls
    gofumpt
  ];
  elixir = with pkgs-unstable; [
    elixir_1_16
    elixir-ls
  ];
  rust = with pkgs-unstable; [
    rustc
    rust-analyzer
    cargo
    clippy
    rustfmt
  ];
  nix = with pkgs-unstable; [
    nil
    nixfmt-rfc-style
  ];
  lua = with pkgs-unstable; [ stylua ];
  shell = with pkgs-unstable; [
    bash-language-server
    shfmt
  ];
  javascript = with pkgs-unstable; [
    typescript-language-server
    tailwindcss-language-server
    astro-language-server
    pnpm
    nodejs
    deno
    prettierd
    typescript
    nodePackages."@astrojs/language-server"
    # to be able to view built static websites on localhost
    live-server
    # INFO: to globally install npm packages use the following two commands:
    # npm config set prefix "${HOME}/.cache/npm/global"
    # mkdir -p "${HOME}/.cache/npm/global"
    # after this we can run npm install -g <pkg>
    # 
    # Installed packages this way:
    # @mdx-js/language-server
  ];
  c = with pkgs-unstable; [
    clang
    mold
  ];
in
{
  home.packages = haskell ++ rust ++ nix ++ lua ++ c ++ shell ++ javascript ++ go ++ elixir;

  # disable update check for pnpm
  xdg.configFile."pnpm/rc".source =
    let
      keyValue = pkgs.formats.keyValue { };
    in
    keyValue.generate "rc" { update-notifier = false; };
}
