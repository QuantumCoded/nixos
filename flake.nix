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

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      specialArgs = { inherit inputs self; };
      moduleArgs = { inherit pkgs inputs self; };

      mkHome = modules: home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = specialArgs;
      };
    in
    {
      inherit (import ./packages specialArgs) packages;
      lib = import ./libraries moduleArgs;

      nixosConfigurations = {
        hydrogen = import ./hosts/hydrogen.nix specialArgs;
        odyssey = import ./hosts/odyssey.nix specialArgs;
        quantum = import ./hosts/quantum.nix specialArgs;
      };

      homeConfigurations = {
        "jeff@hydrogen" = mkHome [ (import ./home/jeff/hydrogen.nix moduleArgs) ];
        "jeff@odyssey" = mkHome [ (import ./home/jeff/odyssey.nix moduleArgs) ];
        "jeff@quantum" = mkHome [ (import ./home/jeff/quantum.nix moduleArgs) ];
      };
    };
}
