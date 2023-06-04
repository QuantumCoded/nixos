{ config, ... }: {
  age.secrets.email.file = ../secrets/email.age;

  programs.git = {
    enable = true;
    userEmail = config.age.secrets.email.path;
    userName = "QuantumCoded";
    extraConfig.pull.rebase = false;
  };
}
