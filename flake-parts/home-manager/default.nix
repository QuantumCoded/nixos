_: { config, lib, ... }: {
  flake.homeModules =
    let
      modules = {
        fish = import ./fish;
        neofetch = import ./neofetch;
        dunst = import ./dunst.nix;
        firefox = import ./firefox.nix;
        git = import ./git.nix;
        kitty = import ./kitty.nix;
        rofi = import ./rofi.nix;
        sxhkd = import ./sxhkd.nix;
        vscode = import ./vscode.nix;
      };

      default.imports = lib.mapAttrsToList (_: mod: mod) modules;
    in
    modules // { inherit default; };
}
