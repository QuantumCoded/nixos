{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-raccoon.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    nur.url = "github:nix-community/NUR";
    base16.url = "github:SenchoPens/base16.nix";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = inputs:
    with inputs;
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      specialArgs = { inherit inputs self; };
      extraSpecialArgs = specialArgs;

      nixosCommonModules = [
        ./overlays.nix
        ./common.nix
        ./scheme.nix

        base16.nixosModule
        agenix.nixosModules.default

        home-manager.nixosModules.home-manager
        {
          home-manager = { inherit extraSpecialArgs; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];

      homeManagerCommonModules = [
        ./overlays.nix
        ./scheme.nix

        base16.homeManagerModule
      ];
    in
    {
      nixosConfigurations = {
        quantum = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;

          modules = [
            ./hosts/quantum/configuration.nix
            { home-manager.users.jeff.imports = [ ./users/jeff/home ./users/hosts/quantum.nix ]; }
          ]
          ++ nixosCommonModules;
        };

        odyssey = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;

          modules = [
            ./hosts/odyssey/configuration.nix
            { home-manager.users.jeff.imports = [ ./users/jeff/home ./users/hosts/odyssey.nix ]; }
          ]
          ++ nixosCommonModules;
        };
      };

      homeConfigurations = {
        "jeff@quantum" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs extraSpecialArgs;
          modules =
            [ ./users/jeff/home ./users/hosts/quantum.nix ]
            ++ homeManagerCommonModules;
        };

        "jeff@odyssey" = {
          inherit pkgs extraSpecialArgs;
          modules =
            [ ./users/jeff/home ./users/hosts/odyssey.nix ]
            ++ homeManagerCommonModules;
        };

        "jeff" = {
          inherit pkgs extraSpecialArgs;
          modules =
            [ ./users/jeff/home ]
            ++ homeManagerCommonModules;
        };
      };
    };
}
