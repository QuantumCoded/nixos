{
  networking.firewall = {
    allowedTCPPorts = [ 21 ];
    allowedTCPPortRanges = [{ from = 56250; to = 56260; }];
  };

  services.vsftpd = {
    enable = true;
    localUsers = true;
    userlist = [ "sender" ];
    writeEnable = true;
    chrootlocalUser = true;
    extraConfig = ''
      pasv_min_port=56250
      pasv_max_port=56260
      file_open_mode=0777
      local_umask=0
    '';
    allowWriteableChroot = true;
  };

  users.users.sender = {
    isNormalUser = true;
    password = "sender";
    createHome = true;
    home = "/data/documents/sender";
    homeMode = "777";
  };
}
