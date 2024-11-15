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
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nur,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
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
              pkgs-unstable = import nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
              };
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
