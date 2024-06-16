{
  networking.firewall.allowedTCPPorts = [ 2049 ];

  services.nfs.server = {
    enable = true;
    exports = ''
      /data  10.0.0.0/16(insecure,rw,sync,no_subtree_check)
    '';
  };
}
