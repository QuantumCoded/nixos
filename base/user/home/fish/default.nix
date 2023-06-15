{ enableTide ? true }:
{ pkgs, lib, ... }:

{
  programs.fish = with builtins // lib.strings; {
    enable = true;

    plugins =
      if enableTide then [{ name = "tide"; src = pkgs.fishPlugins.tide.src; }]
      else [ ];

    interactiveShellInit = lib.optionalString
      enableTide
      (concatMapStrings readFile [
        ./uvars/style.fish
        ./uvars/settings.fish
        ./uvars/tide.fish
      ]);
  };
}
