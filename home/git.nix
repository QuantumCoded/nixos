{ config, ... }: {
  age.secrets.email.file = ../secrets/email.age;

  programs.git = {
    userEmail = config.age.secrets.email.path;
    userName = "QuantumCoded";
  };
}