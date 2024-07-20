{ ... }:

{
  config.flake.roleModules = {
    desktop = import ./modules/desktop.nix;
    laptop = import ./modules/laptop.nix;
    server = import ./modules/server.nix;
    workstation = import ./modules/workstation.nix;
  };
}
