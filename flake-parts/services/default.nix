{ lib, ... }:
let
  inherit (lib)
    mkOption
    types
    ;
in
{
  options.flake.serviceModules = mkOption {
    type = with types; attrsOf deferredModule;
    default = { };
  };

  config.flake.serviceModules = {
    atticd = import ./modules/atticd.nix;
    caddy = import ./modules/caddy.nix;
    forgejo = import ./modules/forgejo.nix;
    gitea-actions = import ./modules/gitea-actions.nix;
    gonic = import ./modules/gonic.nix;
    grafana = import ./modules/grafana.nix;
    homepage = import ./modules/homepage.nix;
    invidious = import ./modules/invidious.nix;
    jellyfin = import ./modules/jellyfin.nix;
    navidrome = import ./modules/navidrome.nix;
    nfs = import ./modules/nfs.nix;
    pgadmin = import ./modules/pgadmin.nix;
    postgresql = import ./modules/postgresql.nix;
    searx = import ./modules/searx.nix;
    syncthing = import ./modules/syncthing.nix;
    vikunja = import ./modules/vikunja.nix;
    vsftpd = import ./modules/vsftpd.nix;
    woodpecker = import ./modules/woodpecker.nix;
  };
}
