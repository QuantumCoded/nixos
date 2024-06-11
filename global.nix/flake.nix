{
  inputs = {
    nixpkgs.url = "github:nix-community/nixpkgs.lib";
    flake-parts.url = "github:hercules-ci/flake-parts";
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, ... }: 
    inputs.flake-parts.lib.mkFlake { inherit inputs; } 
      ({ flake-parts-lib, ... }: {
        imports = [ ./lib.nix ];

        flake = rec {
          flakeModules.default = flake-parts-lib.importApply ./flake-module.nix {
            homeModule = homeModules.default;
            nixosModule = nixosModules.default;
          };

          homeModules.default = import ./home-module.nix;
          nixosModules.default = import ./nixos-module.nix;
        };
      });
}
