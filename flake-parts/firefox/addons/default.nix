{ config, ... }:

{
  perSystem = { pkgs, system, ... }:
    let
      inherit (config.flake.builders.${system}) buildFirefoxXpiAddon;
      args = { inherit buildFirefoxXpiAddon; };
    in
    {
      firefoxAddons = {
        yomitan = pkgs.callPackage ./yomitan.nix args;
      };
    };
}
