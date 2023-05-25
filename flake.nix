{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    nur.url = "github:nix-community/NUR";
    stylix.url = "github:danth/stylix/release-22.11";
  };

  outputs = {
    self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , nur
    , stylix
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
              nixpkgs-unstable
              nur;
            home = home-manager;
            };

          modules = [
            ./configuration.nix
            ./overlays.nix
            ./stylix.nix

            nur.hmModules.nur
            stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jeff = import ./home;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to ./home/default.nix
            }
          ];
        };
      };
    };
}