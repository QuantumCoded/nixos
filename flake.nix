{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-racoon.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    nur.url = "github:nix-community/NUR";
    base16.url = "github:SenchoPens/base16.nix";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = inputs:
    with inputs;
    let
      system = "x86_64-linux";
      
      specialArgs = { inherit (inputs) self; };

      commonModules = [
        ./overlays.nix
        ./common.nix

        nur.hmModules.nur
        base16.nixosModule
        agenix.nixosModules.default

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jeff = import ./home;
          home-manager.extraSpecialArgs = { inherit (inputs) self; };
        }
      ];
    in
    {
      nixosConfigurations = {
        quantum = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;

          modules = [
            ./hosts/quantum/configuration.nix
          ]
          ++ commonModules;
        };

        odyssey = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;

          modules = [
            ./hosts/odyssey/configuration.nix
          ]
          ++ commonModules;
        };
      };
    };
}
