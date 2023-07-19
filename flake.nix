{
  description = "NixOS configuration";

  inputs = {
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-raccoon.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    utils.url = "github:numtide/flake-utils";

    base16.url = "github:SenchoPens/base16.nix";
    base16-kitty = {
      flake = false;
      url = "github:kdrag0n/base16-kitty";
    };
  };

  outputs = inputs:
    with inputs;
    let
      system = "x86_64-linux";

      fpkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      specialArgs = { inherit inputs self; };
      moduleArgs = { inherit fpkgs inputs self; };

      mkNixos = system: config: nixpkgs.lib.nixosSystem {
        inherit specialArgs system;
        modules = [ ./overlays.nix ./modules/nixos config ];
      };

      mkHome = config: home-manager.lib.homeManagerConfiguration {
        pkgs = fpkgs;
        extraSpecialArgs = specialArgs;
        modules = [ ./overlays.nix ./modules/home config ];
      };
    in
    {
      inherit (import ./packages moduleArgs) packages;
      lib = import ./libraries moduleArgs;

      nixosConfigurations = {
        hydrogen = mkNixos "x86_64-linux" ./hosts/hydrogen;
        # odyssey = import ./hosts/odyssey specialArgs;
        quantum = mkNixos "x86_64-linux" ./hosts/quantum;
      };

      homeConfigurations = {
        "jeff@hydrogen" = mkHome ./home/jeff/hydrogen.nix;
        # "jeff@odyssey" = mkHome [ (import ./home/jeff/odyssey.nix moduleArgs) ];
        "jeff@quantum" = mkHome ./home/jeff/quantum.nix;
      };
    };
}
