{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      return-youtube-dislikes
      web-scrobbler
      sponsorblock
      tree-style-tab
      # yomichan
    ];
  };
}