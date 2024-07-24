{
  homeManager = { pkgs, ... }: {
    xsession.windowManager.bspwm = {
      enable = true;

      extraConfig = ''
        ${pkgs.procps}/bin/pkill sxhkd && sxhkd &
        ${pkgs.dunst}/bin/dunst &
      '';
    };

    base = {
      dunst.enable = true;
      firefox.enable = true;

      fish = {
        enable = true;
        tide.enable = true;
      };

      git.enable = true;
      kitty.enable = true;
      neofetch.enable = true;
      rofi.enable = true;
      sxhkd.enable = true;
    };
  };

  nixos = {
    base.pipewire.denoising = true;
  };
}
