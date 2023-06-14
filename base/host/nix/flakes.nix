{}:
{ pkgs, ... }:

{
  # Enable Nix flake packages.
  nix.package = pkgs.nixFlakes;

  # Experimental features.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
