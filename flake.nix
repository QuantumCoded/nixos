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

    devshell = {
      url = "github:numtide/devshell";
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
    nixpkgs-tapir.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    auto-zones.url = "github:the-computer-club/automous-zones";
    lynx.url = "github:the-computer-club/lynx";

    homelab.url = "git+http://git.hydrogen.lan/quantumcoded/homelab.git";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; }
      ({ config, options, ... }:
        let
          flakeModules = {
            airsonic = import ./flake-parts/airsonic;
            ankisyncd = import ./flake-parts/ankisyncd;
            deemix = import ./flake-parts/deemix;
            firefox = import ./flake-parts/firefox;
            hardware = import ./flake-parts/systems/hardware;
            home-manager = import ./flake-parts/home-manager;
            hosts = import ./flake-parts/systems/hosts;
            kiwix = import ./flake-parts/kiwix;
            libraries = import ./flake-parts/libraries;
            machines = import ./flake-parts/systems/machines;
            minecraft = import ./flake-parts/minecraft;
            nixos = import ./flake-parts/nixos;
            nvidia = import ./flake-parts/nvidia;
            overlays = import ./flake-parts/overlays.nix;
            packages = import ./flake-parts/packages;
            roles = import ./flake-parts/roles;
            services = import ./flake-parts/services;
            transpose = import ./flake-parts/transpose;
            users = import ./flake-parts/systems/users;
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
            kiwix
            libraries
            machines
            minecraft
            nixos
            nvidia
            overlays
            packages
            roles
            services
            transpose
            users
            wireguard

            inputs.devshell.flakeModule

            inputs.lynx.flakeModules.flake-guard
            inputs.auto-zones.flakeModules.asluni
          ];

          systems = [ "x86_64-linux" ];

          perSystem = { inputs', pkgs, ... }: {
            devshells.default = {
              commands = [
                {
                  help = "run nixpkgs-fmt";
                  name = "fmt";
                  command = "nixpkgs-fmt .";
                }
                {
                  help = "starts neovim";
                  name = "nvim";
                  command = "nix run --refresh github:quantumcoded/neovim";
                }
              ];

              env = [
                {
                  name = "LOCAL_KEY";
                  value = "/etc/nixos/keys/binary-cache-key.pem";
                }
              ];

              packages = with pkgs; [
                inputs'.agenix.packages.default
                attic-client
                deadnix
                deploy-rs
                git-lfs
                statix
              ];
            };
          };

          flake = {
            _config = config;
            _options = options;

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
