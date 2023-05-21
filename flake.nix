{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
  };

  outputs = {
    self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
  }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        dell = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit
              self
              system
              nixpkgs
              nixpkgs-unstable;
            home = home-manager;
            };

          modules = [
            ./configuration.nix
            ./overlays.nix
          ];
        };
      };
    };
}