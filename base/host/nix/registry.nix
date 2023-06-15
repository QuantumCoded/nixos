{}:
{ inputs, ... }:

{
  # Add all flake inputs to nix registry.
  nix.registry = builtins.mapAttrs (_: flake: { inherit flake; }) inputs;
}
