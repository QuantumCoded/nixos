{ shells }:
{ lib, pkgs, ... }:

{
  # Define the shells for user accounts.
  environment.shells = map (shell: pkgs.${shell}) shells;

  # Enable the shells.
  programs = lib.mkMerge (map (shell: { ${shell}.enable = true; }) shells);
}
