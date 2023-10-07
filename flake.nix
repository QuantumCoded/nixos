{
  description = "NixOS configuration";

  inputs = {
    agenix.url = "github:ryantm/agenix";
    deploy-rs.url = "github:serokell/deploy-rs";
    disko.url = "github:nix-community/disko?ref=00169fe4a6015a88c3799f0bf89689e06a4d4896";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-raccoon.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim/nixos-23.05";
    nur.url = "github:nix-community/NUR";
    rust-overlay.url = "github:oxalica/rust-overlay";
    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

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
      moduleArgs = specialArgs // { nixpkgs = pkgs; };

      mkNixos = system: config: nixpkgs.lib.nixosSystem {
        inherit specialArgs system;
        modules = [
          agenix.nixosModules.default
          disko.nixosModules.disko
          nixvim.nixosModules.nixvim
          ./common.nix
          ./overlays.nix
          ./modules/nixos
          ./modules/nixvim
          config
        ];
      };

      mkHome = config: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = specialArgs;
        modules = [
          ./overlays.nix
          ./modules/home
          config
        ];
      };
    in
    {
      inherit (import ./packages moduleArgs) packages;
      lib = import ./libraries moduleArgs;

      nixosConfigurations = {
        hydrogen = mkNixos "x86_64-linux" ./hosts/hydrogen;
        odyssey = mkNixos "x86_64-linux" ./hosts/odyssey;
        quantum = mkNixos "x86_64-linux" ./hosts/quantum;
      };

      homeConfigurations = {
        "jeff@hydrogen" = mkHome ./home/jeff/hydrogen.nix;
        "jeff@odyssey" = mkHome ./home/jeff/odyssey.nix;
        "jeff@quantum" = mkHome ./home/jeff/quantum.nix;
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          agenix.packages.${system}.default
          colmena
          deploy-rs
          git-lfs
          just
        ];

        shellHook = ''
          export LOCAL_KEY=/etc/nixos/keys/binary-cache-key.pem
        '';
      };

      deploy.nodes = {
        hydrogen = {
          hostname = "hydrogen.lan";
          profiles.system = {
            user = "root";
            sshUser = "root";
            sshOpts = [ "-t" ];
            path = deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.hydrogen;
          };
        };
      };

      colmena = {
        meta = {
          nixpkgs = pkgs;
          inherit specialArgs;
        };

        hydrogen = {
          deployment = {
            targetHost = "hydrogen.lan";
            buildOnTarget = true;
          };

          imports = [
            agenix.nixosModules.default

            ./common.nix
            ./overlays.nix
            ./modules/nixos
            ./hosts/hydrogen
          ];
        };
      };
    };
}
