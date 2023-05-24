{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    # TODO: Replace this with pkgs.firefox when home-manager is updated
    package = pkgs.firefox-esr;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      return-youtube-dislikes
      web-scrobbler
      sponsorblock
      tree-style-tab

      # TODO: Manually add these extensions
      # yomichan
    ];
  };
}