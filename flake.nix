{
  inputs = {
    hardware-configuration = {
      url = "path:/etc/nix/hardware.nix";
      flake = false;
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix.url = "github:NikitaRevenco/helix/personal";
    playwright.url = "github:pietdevries94/playwright-web-flake/1.47.0";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nur,
      playwright,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      overlay = final: prev: {
        inherit (playwright.packages.${system}) playwright-driver playwright-test;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        overlays = [ overlay ];
      };
      specialArgs = {
        inherit pkgs-unstable inputs;
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./configuration.nix
          nur.nixosModules.nur
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.e = {
              imports = [
                ./home.nix
                inputs.nur.hmModules.nur
              ];
            };
          }
        ];
      };
    };
}
