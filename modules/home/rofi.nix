{ config, lib, pkgs, ... }:
let
  inherit (pkgs) writeText;
  inherit (lib)
    assertMsg
    concatStringsSep
    mapAttrsToList
    mkEnableOption
    mkIf
    mkMerge
    mkOption
    types
    ;

  cfg = config.base.rofi;
in
{
  options.base.rofi = {
    enable = mkEnableOption "Rofi";
    websites.enable = mkEnableOption "Rofi Websites";
    websites = {
      sites = mkOption {
        type = with types; attrsOf str;
        default = { };
      };
      keybind = mkOption {
        type = types.str;
        default = "super + shift + w";
      };
    };
    ide = {
      enable = mkEnableOption "Rofi IDE";
      keybind = mkOption {
        type = types.str;
        default = "super + shift + i";
      };
    };
  };

  config =
    let
      fish = "${pkgs.fish}/bin/fish";

      command = {
        websites =
          let
            separator = "█";
            formatWebsite = name: value: "${name}${separator}${value}";
            websites = mapAttrsToList formatWebsite cfg.websites.sites;
            websitesFile = writeText "rofi-websites" (concatStringsSep "\n" websites);
            script = writeText "rofi-websites.fish" ''
              xdg-open (cat ${websitesFile} | column -ts '${separator}' | rofi -dmenu | grep -oP '\S+$')
            '';
          in
          "${fish} ${script}";

        ide =
          let
            # FIXME: this should not open the ide if rofi exits with anything other than 0
            script = writeText "rofi-ide.fish" ''
              ide (echo echo (rofi -dmenu -p 'path' -theme-str 'listview { enabled: false; }') | ${fish})
            '';
          in
          # FIXME: these don't print as bools, but 1 and ""
          assert (assertMsg (!(cfg.ide.enable && !config.base.fish.funcs.ide.enable)) ''
            Cannot enable Rofi IDE `base.rofi.ide` without enabling `base.fish.funcs.ide`
            base.rofi.ide.enable = ${toString cfg.ide.enable};
            base.fish.funcs.ide.enable = ${toString config.base.fish.funcs.ide.enable};
          '');
          "${fish} ${script}";
      };
    in
    mkIf cfg.enable
      {
        programs.rofi = {
          enable = true;
          # TODO: consolodate font info
          font = "FiraCode Nerd Font Mono 10";
        };

        services.sxhkd.keybindings = mkMerge [
          (mkIf cfg.websites.enable { ${cfg.websites.keybind} = command.websites; })
          (mkIf cfg.ide.enable { ${cfg.ide.keybind} = command.ide; })
        ];
      };
}
