{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    plugins = [
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
    ];
  };

  # Load missing fish functions.
  home.file = {
    ".config/fish/functions/_tide_item_direnv.fish".source = ./fish-functions/_tide_item_direnv.fish;
    ".config/fish/functions/_tide_item_distrobox.fish".source = ./fish-functions/_tide_item_distrobox.fish;
    ".config/fish/functions/_tide_item_elixir.fish".source = ./fish-functions/_tide_item_elixir.fish;
    ".config/fish/functions/_tide_item_gcloud.fish".source = ./fish-functions/_tide_item_gcloud.fish;
    ".config/fish/functions/_tide_item_pulumi.fish".source = ./fish-functions/_tide_item_pulumi.fish;
  };
}
