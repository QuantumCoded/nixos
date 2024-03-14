_: { config, lib, ... }: {
  flake.homeModules =
    let
      modules = {
        fish = import ../home-manager/fish;
        neofetch = import ../home-manager/neofetch;
        dunst = import ../home-manager/dunst.nix;
        firefox = import ../home-manager/firefox.nix;
        git = import ../home-manager/git.nix;
        kitty = import ../home-manager/kitty.nix;
        rofi = import ../home-manager/rofi.nix;
        sxhkd = import ../home-manager/sxhkd.nix;
        vscode = import ../home-manager/vscode.nix;
      };

      default.imports = lib.mapAttrsToList (_: path: path) modules;
    in
      modules // { inherit default; };
}
