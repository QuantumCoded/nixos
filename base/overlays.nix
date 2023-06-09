{ enableNur ? true
, enableRaccoon ? true
, enableUnstable ? true
}:
{ inputs, lib, pkgs, ... }:
with inputs;
let
  system = pkgs.stdenv.hostPlatform.system;

  overlay-raccoon = final: prev: {
    raccoon = import nixpkgs-raccoon {
      inherit system;
      config.allowUnfree = true;
    };
  };

  overlay-unstable = final: prev: {
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  };
in
{
  nixpkgs.overlays = lib.mkMerge [
    (lib.mkIf (enableNur) [ nur.overlay ])
    (lib.mkIf (enableRaccoon) [ overlay-raccoon ])
    (lib.mkIf (enableUnstable) [ overlay-unstable ])
  ];
}
