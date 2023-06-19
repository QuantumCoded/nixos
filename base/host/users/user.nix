{ description ? null
, extraGroups ? [ "networkmanger" "wheel" ]
, packages ? [ ]
, isNormalUser ? true
, shell ? null
, userName
}:
{ lib, pkgs, self, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userName} = lib.mkMerge [
    {
      inherit extraGroups isNormalUser packages;
      description = lib.optionalString
        (description != null)
        (self.lib.capitalizeFirst description);
    }

    (if shell == null then
      { shell = pkgs.fish; }
    else
      { inherit shell; })

    (lib.mkIf (packages == [ ]) {
      packages = with pkgs; [
        anki
        btop
        comma
        element-desktop
        feh
        file
        flameshot
        home-manager
        kate
        libreoffice
        man-pages
        man-pages-posix
        mpv
        neofetch
        nil
        nix-index
        nixpkgs-fmt
        noisetorch
        obsidian
        pavucontrol
        python3
        raccoon.kitty
        rustup
        sonixd
        steam
        thunderbird
        tree
        unstable.discord
        vlc
        vulnix
        wireguard-tools
        xclip
      ];
    })
  ];
}
