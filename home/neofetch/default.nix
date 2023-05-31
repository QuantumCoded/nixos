{ pkgs, ... }:
{
  # Link neofetch config to the nix store.
  home.file.".config/neofetch/config.conf".source = ./config.conf;
  
  # Link the neofetch logo to the nix store.
  # FIXME: neofetch seems to get really cranky when trying to load images from the nix
  home.file.".config/neofetch/logo.svg" = {
    source = ./logo.svg;

    # Clear neofetch thumbnail cache when the neofetch logo changes.
    onChange = ''
      ${pkgs.neofetch}/bin/neofetch --clean
    '';
  };
}