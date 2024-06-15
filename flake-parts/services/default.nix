{
  flake.serviceModules = {
    atticd = import ./atticd.nix;
    caddy = import ./caddy.nix;
    forgejo = import ./forgejo.nix;
    gitea-actions = import ./gitea-actions.nix;
    gonic = import ./gonic.nix;
    grafana = import ./grafana.nix;
    homepage = import ./homepage.nix;
    invidious = import ./invidious.nix;
    jellyfin = import ./jellyfin.nix;
    navidrome = import ./navidrome.nix;
    nfs = import ./nfs.nix;
    pgadmin = import ./pgadmin.nix;
    postgresql = import ./postgresql.nix;
    searx = import ./searx.nix;
    syncthing = import ./syncthing.nix;
    vikunja = import ./vikunja.nix;
    vsftpd = import ./vsftpd.nix;
    woodpecker = import ./woodpecker.nix;
  };
}
