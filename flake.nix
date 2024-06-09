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

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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


    shard = {
      url = "path:/etc/nixos/shard";
      inputs.flake-parts.follows = "flake-parts";
    };
  };

  outputs = inputs:
    inputs.shard.lib.mkFlake { inherit inputs; }
      (args @ { config, options, flake-parts-lib, ... }:
        let
          inherit (flake-parts-lib) importApply;

          flakeModules = {
            firefox = importApply ./flake-parts/firefox args;
            hardware = importApply ./flake-parts/hardware args;
            home-manager = importApply ./flake-parts/home-manager args;
            hosts = importApply ./flake-parts/hosts args;
            libraries = importApply ./flake-parts/libraries args;
            machines = importApply ./flake-parts/machines.nix args;
            nixos = importApply ./flake-parts/nixos args;
            packages = importApply ./flake-parts/packages args;
            roles = importApply ./flake-parts/roles args;
            transpose = importApply ./flake-parts/transpose args;
            users = importApply ./flake-parts/users args;
            wireguard = importApply ./flake-parts/wireguard args;
          };
        in
        {
          imports = with flakeModules; [
            firefox
            hardware
            home-manager
            hosts
            libraries
            machines
            nixos
            packages
            roles
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
            _config = config;
            _options = options;

            inherit flakeModules;

            testoutput = "helloworld";

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

          shard = {
            enable = true;
            source = ./nix;

            extract = [
              [ "shard" "test" ]
            ];
          };
        });
}
