{ config, lib, ... }:
let
  inherit (config.flake.lib)
    combineModules
    ;

  inherit (lib)
    mkOption
    types
    ;
in
{
  options.flake.homeModules = mkOption {
    type = types.attrs;
    default = { };
  };

  config.flake.homeModules = {
    neofetch = import ./modules/neofetch;
    dunst = import ./modules/dunst.nix;
    fish = import ./modules/fish.nix;
    git = import ./modules/git.nix;
    kitty = import ./modules/kitty.nix;
    rofi = import ./modules/rofi.nix;
    sxhkd = import ./modules/sxhkd.nix;
    zoxide = import ./modules/zoxide.nix;
    default.imports = combineModules config.flake.homeModules;
  };
}
