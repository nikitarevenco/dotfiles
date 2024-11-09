{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    helix.url = "github:helix-editor/helix/master";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # helix-git.url = "github:helix-editor/helix/master";
    # nur.url = "github:nix-community/NUR";
    # home-manager.url = "github:nix-community/home-manager/release-24.05";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./configuration.nix
        ];
      };
    };
}
