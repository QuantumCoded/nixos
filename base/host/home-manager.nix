{ modules, userName }:
{ inputs, self, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager.extraSpecialArgs = { inherit inputs self; };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${userName}.imports = modules;
  # home.stateVersion = "23.05";
}
