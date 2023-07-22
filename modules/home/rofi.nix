{ config, lib, pkgs, ... }:
let
  inherit (builtins) replaceStrings;
  inherit (lib)
    assertMsg
    concatStringsSep
    foldlAttrs
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
      command = {
        websites =
          let
            sanitize = string:
              replaceStrings
                [ "'" "\n" "\t" "&" ]
                [ "\\'" "\\n" "\\t" "\&" ]
                string;
            formatSites = acc: name: value: acc ++ [ "${name}|${value}" ];
            formattedSites = foldlAttrs formatSites [ ] cfg.websites.sites;
            rofiInput = sanitize (concatStringsSep "\n" formattedSites);
          in
          ''
            xdg-open `echo -e '${rofiInput}' | column -ts '|' | rofi -dmenu | grep -oP '\S+$'`
          '';

        ide =
          let
            script = pkgs.writeText "rofi-ide.fish" ''
              ide (rofi -dmenu -p 'path' -theme-str 'listview { enabled: false; }')
            '';
          in
          assert (assertMsg (!(cfg.ide.enable && !config.base.fish.funcs.ide.enable)) ''
            Cannot enable Rofi IDE `base.rofi.ide` without enabling `base.fish.funcs.ide`
            base.rofi.ide.enable = ${toString cfg.ide.enable};
            base.fish.funcs.ide.enable = ${toString config.base.fish.funcs.ide.enable};
          '');
          ''
            fish ${script}
          '';
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
