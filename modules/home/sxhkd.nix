{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  pactl = "${pkgs.pulseaudio}/bin/pactl";
  cfg = config.base.sxhkd;
in
{
  options.base.sxhkd = {
    enable = mkEnableOption "Enable SXHKD";
    desktopOrder = mkOption {
      type = types.str;
      default = "1-9,10";
    };
  };

  config = mkIf cfg.enable {
    services.sxhkd = {
      enable = true;

      keybindings = {
        #
        # application hotkeys
        #

        # libreoffice
        "super + l" = "libreoffice";

        # obsidian
        "super + o" = "obsidian";

        # discord
        "super + d" = "discord";

        # vscode
        "super + v" = "codium";

        # firefox
        "super + w" = "firefox";

        # firefox private
        "super + alt + w" = "firefox --private-window";

        # email client
        "super + e" = "thunderbird";

        # rofi calculator
        "super + BackSpace" = "rofi -show calc -modi calc -no-show-match -no-sort";

        #
        # volume control hotkeys
        #

        # volume up
        "XF86AudioRaiseVolume" = "${pactl} set-sink-volume 0 +5%;";

        # volume down
        "XF86AudioLowerVolume" = "${pactl} set-sink-volume 0 -5%;";

        # mute
        "XF86AudioToggle" = "${pactl} set-sink-mute 0 true";

        #
        # wm independent hotkeys
        #

        # screenshot
        "Print" = "flameshot gui";

        # terminal emulator
        "super + Return" = "kitty";

        # program launcher
        "super + @space" = "rofi -show run";

        # window switcher
        "super + Tab" = "rofi -show window";

        # make sxhkd reload its configuration files:
        "super + Escape" = "pkill -USR1 -x sxhkd";

        # suspend the system
        "super + shift + s" = "systemctl suspend";

        #
        # bspwm hotkeys
        #

        # quit/restart bspwm
        "super + alt + {q,r}" = "bspc {quit,wm -r}";

        # close and kill
        "super + {_,shift + }q" = "bspc node -{c,k}";

        # alternate between the tiled and monocle layout
        "super + m" = "bspc desktop -l next";

        # send the newest marked node to the newest preselected node
        "super + y" = "bspc node newest.marked.local -n newest.!automatic.local";

        # swap the current node and the biggest window
        "super + g" = "bspc node -s biggest.window";

        #
        # state/flags
        #

        # set the window state
        "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";

        # set the node flags
        "super + ctrl + {m,x,y,z}" = "bspc node -g {marked,locked,sticky,private}";

        #
        # focus/swap
        #

        # focus the node in the given direction
        "super + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";

        # focus the node for the given path jump
        "super + {p,b,comma,period}" = "bspc node -f @{parent,brother,first,second}";

        # focus the next/previous window in the current desktop
        "super + {_,shift + }c" = "bspc node -f {next,prev}.local.!hidden.window";

        # focus the next/previous desktop in the current monitor
        "super + bracket{left,right}" = "bspc desktop -f {prev,next}.local";

        # focus the last node/desktop
        "super + {_,alt + }grave" = "bspc {node,desktop} -f last";

        # focus the older or newer node in the focus history
        "super + {o,i}" = ''
          bspc wm -h off;
          bspc node {older,newer} -f;
          bspc wm -h on
        '';

        # focus or send to the given desktop
        "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{${cfg.desktopOrder}}'";

        #
        # preselect
        #

        # preselect the direction
        "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";

        # preselect the ratio
        "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";

        # cancel the preselection for the focused node
        "super + ctrl + space" = "bspc node -p cancel";

        # cancel the preselection for the focused desktop
        "super + ctrl + shift + space" = "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";

        #
        # move/resize
        #

        # expand a window by moving one of its side outward
        "super + alt + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";

        # contract a window by moving one of its side inward
        "super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";

        # move a floating window
        "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
      };
    };
  };
}
