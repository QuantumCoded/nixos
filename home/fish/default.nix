{ pkgs, lib, ... }:
{
  programs.fish = with builtins // lib.strings; {
    enable = true;
    plugins = [
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
    ];
    interactiveShellInit = concatMapStrings readFile [
      ./uvars/fish.fish
      ./uvars/settings.fish
      ./uvars/tide.fish
    ];
  };

  # Load missing fish functions.
  home.file = {
    ".config/fish/functions/_tide_item_direnv.fish".source = ./functions/_tide_item_direnv.fish;
    ".config/fish/functions/_tide_item_distrobox.fish".source = ./functions/_tide_item_distrobox.fish;
    ".config/fish/functions/_tide_item_elixir.fish".source = ./functions/_tide_item_elixir.fish;
    ".config/fish/functions/_tide_item_gcloud.fish".source = ./functions/_tide_item_gcloud.fish;
    ".config/fish/functions/_tide_item_pulumi.fish".source = ./functions/_tide_item_pulumi.fish;
  };
}
