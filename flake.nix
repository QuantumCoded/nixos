{
  description = "NixOS configuration";

  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    attic = {
      url = "github:zhaofengli/attic";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
      };
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko?ref=00169fe4a6015a88c3799f0bf89689e06a4d4896";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    auto-zones.url = "github:the-computer-club/automous-zones";
    lynx.url = "github:the-computer-club/lynx";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; }
      ({ config, flake-parts-lib, ... }:
        let
          flakeModules = {
            airsonic = import ./flake-parts/airsonic;
            ankisyncd = import ./flake-parts/ankisyncd;
            deemix = import ./flake-parts/deemix;
            firefox = import ./flake-parts/firefox;
            hardware = import ./flake-parts/hardware;
            home-manager = import ./flake-parts/home-manager;
            hosts = import ./flake-parts/hosts;
            libraries = import ./flake-parts/libraries;
            machines = import ./flake-parts/machines.nix;
            nixos = import ./flake-parts/nixos;
            packages = import ./flake-parts/packages;
            roles = import ./flake-parts/roles;
            services = import ./flake-parts/services;
            transpose = import ./flake-parts/transpose;
            users = import ./flake-parts/users;
            wireguard = import ./flake-parts/wireguard;
          };
        in
        {
          imports = with flakeModules; [
            airsonic
            ankisyncd
            deemix
            firefox
            hardware
            home-manager
            hosts
            libraries
            machines
            nixos
            packages
            roles
            services
            transpose
            users
            wireguard

            inputs.lynx.flakeModules.flake-guard
            inputs.auto-zones.flakeModules.asluni

            ./machines.nix
          ];

          systems = [ "x86_64-linux" ];

          perSystem = { config, inputs', pkgs, ... }: {
            devShells.default = pkgs.mkShell {
              packages = with pkgs; [
                inputs'.agenix.packages.default
                attic-client
                deploy-rs
                git-lfs
              ];

              shellHook = ''
                export LOCAL_KEY=/etc/nixos/keys/binary-cache-key.pem
              '';
            };
          };

          flake = {
            inherit flakeModules;

            deploy.nodes = {
              hydrogen = {
                hostname = "hydrogen.lan";
                profiles.system = {
                  user = "root";
                  sshUser = "root";
                  sshOpts = [ "-T" ];
                  path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos config.flake.nixosConfigurations.hydrogen;
                };
              };
            };
          };
        });
}
