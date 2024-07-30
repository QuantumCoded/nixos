{
  homeManager = { config, flakeConfig, pkgs, ... }: {
    xsession.windowManager.bspwm = {
      enable = config.roles.workstation;

      extraConfig = ''
        ${pkgs.procps}/bin/pkill sxhkd && sxhkd &
        ${pkgs.dunst}/bin/dunst &
      '';
    };

    base = {
      dunst.enable = true;

      firefox = {
        enable = config.roles.workstation;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          darkreader
          keepassxc-browser
          return-youtube-dislikes
          sponsorblock
          tree-style-tab
          ublock-origin
          web-scrobbler

          flakeConfig.flake.firefoxAddons.${pkgs.system}.yomitan
        ];
      };

      fish = {
        enable = true;
        tide.enable = config.roles.workstation;
      };

      git.enable = true;
      kitty.enable = config.roles.workstation;
      neofetch.enable = config.roles.workstation;
      rofi.enable = config.roles.workstation;
      sxhkd.enable = config.roles.workstation;
      zoxide.enable = true;
    };
  };

  nixos = { config, lib, pkgs, ... }:
    let
      inherit (lib)
        concatLists
        mkIf
        optionals
        ;
    in
    {
      base.pipewire.denoising = config.roles.workstation;

      services = {
        pcscd.enable = true;
        xserver.windowManager.bspwm.enable = config.roles.workstation;
      };

      environment.shells = with pkgs; [ fish ];

      programs = {
        direnv.enable = true;
        fish.enable = true;
      };

      fonts.packages = with pkgs; mkIf config.roles.workstation [
        liberation_ttf
        nerdfonts
        self.nimbus-roman-ttf
      ];

      users.users.jeff = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = concatLists [
          (optionals config.roles.podman [ "podman" ])
          (optionals config.roles.virtualization [ "libvirtd" ])
          (optionals config.roles.syncthing-peer [ "syncthing" ])

          [
            "networkmanager"
            "wheel"
          ]
        ];

        packages = with pkgs; concatLists [
          [
            comma
            emacs
            feh
            file
            man-pages
            man-pages-posix
            neofetch
            nix-index # TODO: see if nix-index can be ran automatically
            wireguard-tools
            keepassxc

            # development
            nil
            nixpkgs-fmt
          ]

          (optionals config.roles.workstation [
            flameshot
            sonixd

            # gaming
            dwarf-fortress
            prismlauncher
            unstable.minetest

            # development
            self.imhex

            # productivity
            anki
            libreoffice
            obsidian
            thunderbird

            # social
            element-desktop
            unstable.vesktop
          ])
        ];
      };
    };
}
