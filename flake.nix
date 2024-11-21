{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    helix.url = "github:NikitaRevenco/helix/personal";
    hardware-configuration = {
      url = "path:/etc/nix/hardware.nix";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    playwright = {
      url = "github:pietdevries94/playwright-web-flake/1.47.0";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
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
      # pkgs = import nixpkgs {
      #   inherit system;
      # };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        overlays = [ overlay ];
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs-unstable;
          inherit inputs;
        };
        modules = [
          ./configuration.nix
          nur.nixosModules.nur
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit pkgs-unstable;
              inherit inputs;
            };
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
