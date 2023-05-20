{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    hm.url = "github:nix-community/home-manager";
  };

  outputs = {
    self
    , nixpkgs
    , nixpkgs-unstable
    , hm
  }:
    let
      ## variables
      system = "x86_64-linux";
      overlay-unstable = system: final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      ## -- end
    in {
      # NixOS config for "dell"
      nixosConfigurations.dell =
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self; };
          modules = [
            ./configuration.nix
            ({config, pkgs, ...}: { nixpkgs.overlays = [ (overlay-unstable system) ]; })
          ];
        };

      # nixos configuration for Pi
      #nixosConfigurations.cherry-pin =
      #  nixpkgs.lib.nixosSystem {
      #     system = "armv7ea-linux";
      #     modules = [];
      #  };
    };
}