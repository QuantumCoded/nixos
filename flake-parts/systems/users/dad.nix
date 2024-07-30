{
  homeManager = { config, ... }: {
    base = {
      firefox.enable = config.roles.workstation;
      git.enable = true;
    };
  };

  nixos = { config, inputs, lib, pkgs, ... }:
    let
      inherit (lib)
        concatLists
        mkIf
        optionals
        ;
    in
    {
      programs = mkIf config.roles.workstation {
        steam.enable = true;
        partition-manager.enable = true;
      };

      services = mkIf config.roles.workstation {
        xserver.desktopManager.plasma5.enable = true;
        displayManager.sddm = {
          enable = true;
          theme = "breeze-custom";
        };
      };

      environment = {
        plasma5.excludePackages = with pkgs.plasma5Packages; [
          elisa
          kwallet
          okular
          spectacle
        ];

        systemPackages = with pkgs; [
          git
          lazygit
          micro
          ntfs3g
          self.breeze-custom
          tmux
          wget
          xclip
        ];
      };

      systemd.targets = {
        sleep.enable = false;
        suspend.enable = false;
        hibernate.enable = false;
        hybrid-sleep.enable = false;
      };

      users.users.${inputs.homelab.userNames.dad} = {
        isNormalUser = true;
        extraGroups = concatLists [
          (optionals config.roles.podman [ "podman" ])
          (optionals config.roles.syncthing-peer [ "syncthing" ])
          [ "wheel" ]
        ];

        packages = with pkgs; concatLists [
          (optionals config.roles.workstation [
            ark
            discord
            firefox
            flameshot
            gwenview
            handbrake
            inkscape
            k3b
            kate
            kcalc
            kdenlive
            kdevelop
            kmix
            krita
            ksystemlog
            libreoffice-qt
            masterpdfeditor
            qbittorrent
            sonixd
            unstable.minetest
            unstable.thunderbird
            vlc
          ])

          [
            distrobox
            hunspell
            hunspellDicts.en_US
            keepassxc
          ]
        ];
      };


      systemd.tmpfiles.rules = [
        "L /usr/share/applications - - - - /run/current-system/sw/share/applications"
      ];
    };
}
