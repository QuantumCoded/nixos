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
            
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jeff = import ./home;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to ./home/default.nix
              home-manager.extraSpecialArgs = {
                inherit nixpkgs;
              };
            }
          ];
        };
      };
    };
}