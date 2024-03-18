{
  machines = {
    quantum = {
      hardware = hardwareModules.quantum;
      homeModules = builtins.attrValues homeModules;
      nixosModules = builtins.attrValues nixosModules;
      host = with hostModules; [ quantum ];
      users = with userModules; [ jeff ];
      roles = with roleModules; [ desktop workstation ];
    };
    quantum-server = {
      hardware = hardwareModules.quantum;
      homeModules = builtins.attrValues homeModules;
      nixosModules = builtins.attrValues nixosModules;
      host = with hostModules; [ hydrogen ];
      users = with userModules; [ jeff ];
      roles = with roleModules; [ server ];
    };
  };
}
