{ inputs, pkgs, ... }:

{
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.registry = builtins.mapAttrs (_: flake: { inherit flake; }) inputs;
}
