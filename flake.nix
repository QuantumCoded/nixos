{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    nur.url = "github:nix-community/NUR";
    base16.url = "github:SenchoPens/base16.nix";
    agenix.url = "github:ryantm/agenix";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , nur
    , base16
    , agenix
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        quantum = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit
              self
              system
              nixpkgs
              nixpkgs-unstable
              nur
              base16;
            home = home-manager;
          };

          modules = [
            ./hosts/quantum/configuration.nix
            ./overlays.nix

            nur.hmModules.nur
            base16.nixosModule
            agenix.nixosModules.default

            ./style
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

        odyssey = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit
              self
              system
              nixpkgs
              nixpkgs-unstable
              nur
              base16;
            home = home-manager;
          };

          modules = [
            ./hosts/odyssey/configuration.nix
            ./overlays.nix

            nur.hmModules.nur
            base16.nixosModule

            ./style
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
