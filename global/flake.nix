{
  inputs = {
    nixpkgs.url = "github:nix-community/nixpkgs.lib";
    flake-parts.url = "github:hercules-ci/flake-parts";
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, ... }: {
    flakeModules = rec {
      default = shard;
      shard = import ./module.nix;
    };

    lib = import ./lib.nix {
      inherit inputs self;
      lib = inputs.nixpkgs.lib;
    };
  };
}
