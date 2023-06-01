{ pkgs, lib, ... }:
{
  programs.fish = with builtins // lib.strings; {
    enable = true;
    plugins = [
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
    ];
    interactiveShellInit = concatMapStrings readFile [
      ./uvars/style.fish
      ./uvars/settings.fish
      ./uvars/tide.fish
    ];
  };
}
