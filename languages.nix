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
  rust = with pkgs-unstable; [
    rustc
    rust-analyzer
    cargo
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
  ];
  c = with pkgs-unstable; [
    clang
    mold
  ];
in
{
  home.packages = haskell ++ rust ++ nix ++ lua ++ c ++ shell ++ javascript ++ go;

  # disable update check for pnpm
  xdg.configFile."pnpm/rc".source =
    let
      keyValue = pkgs.formats.keyValue { };
    in
    keyValue.generate "rc" { update-notifier = false; };
}
