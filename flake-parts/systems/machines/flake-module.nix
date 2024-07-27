{ config, flakeRoot, inputs, lib, self, ... }:
let
  inherit (lib)
    any
    concatLists
    elem
    filterAttrs
    id
    mapAttrs
    mapAttrs'
    mapAttrsToList
    nameValuePair
    mkDefault
    mkOption
    optionalAttrs
    types
    ;

  hybridModule = with types; submodule {
    options = {
      homeManager = mkOption {
        type = nullOr deferredModule;
        default = null;
      };

      nixos = mkOption {
        type = deferredModule;
        default = { };
      };
    };
  };
in
{
  options = {
    machines = mkOption {
      type = with types; attrsOf (submodule {
        options = {
          homeModules = mkOption {
            type = listOf deferredModule;
            default = [ config.flake.homeModules.default ];
          };

          nixosModules = mkOption {
            type = listOf deferredModule;
            default = [ config.flake.nixosModules.default ];
          };

          hardware = mkOption {
            type = deferredModule;
          };

          host = mkOption {
            type = hybridModule;
          };

          users = mkOption {
            type = attrsOf hybridModule;
            default = { };
          };

          userNames = mkOption {
            type = attrsOf str;
            default = { };
          };

          roles = mkOption {
            type = listOf str;
            default = [ ];
          };

          extraHomeManager = mkOption {
            type = nullOr deferredModule;
            default = null;
          };

          extraNixos = mkOption {
            type = deferredModule;
            default = { };
          };

          stateVersion = mkOption {
            type = str;
          };
        };
      });
    };
  };

  config =
    let
      # attrs or empty attrs if attrs is null
      nullableAttrs = attrs: optionalAttrs
        (attrs != null)
        attrs;

      # checks if a machine username pair needs home manager
      userNeedsHomeManager = machine: userName:
        machine.extraHomeManager != null
        || machine.host.homeManager != null
        || machine.users.${userName}.homeManager != null;

      # removes users not using home manager
      filterHomeManagerConfigs = filterAttrs
        (_: homeConfig: homeConfig != null);

      # computes the final username for a machine username pair
      finalUserName = machine: userName:
        machine.userNames.${userName} or userName;

      # makes a home manager module for a machine username pair's config
      # returns a home manager module or null if not needed
      mkHomeManagerConfigModule = machine: userName:
        if !(userNeedsHomeManager machine userName)
        then null
        else {
          imports = [
            (nullableAttrs machine.host.homeManager)
            (nullableAttrs machine.extraHomeManager)
            (nullableAttrs machine.users.${userName}.homeManager)

            {
              imports = machine.homeModules;

              # set used roles to true on home manager side
              roles = mapAttrs
                (roleName: _: elem roleName machine.roles)
                config.roles;

              programs.home-manager.enable = true;

              home = {
                inherit (machine) stateVersion;

                username = mkDefault userName;
                homeDirectory = mkDefault "/home/${userName}";
              };
            }
          ];
        };

      # makes a home manager configuration for a machine user pair
      # returns null if no home manager config is needed
      mkHomeManagerConfig = machine: userName: pkgs:
        if !(userNeedsHomeManager machine userName)
        then null
        else
          inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit flakeRoot inputs self;
              flakeConfig = config;
              nixosConfig = null;
            };

            modules = [
              (nullableAttrs (mkHomeManagerConfigModule machine userName))
            ];
          };


      # checks if a machine or any of its users needs home manager
      nixosNeedsHomeManager = machine: any id
        (mapAttrsToList (userName: _: userNeedsHomeManager machine userName)
          machine.users);

      # makes a nixos module to load home manager
      # returns an empty attrs if the machine does not use hm
      mkHomeManagerNixosModule = machine: optionalAttrs
        (nixosNeedsHomeManager machine)
        (nixosArgs: {
          imports = [ inputs.home-manager.nixosModules.home-manager ];

          # configure home-manager in nixos scope
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit flakeRoot inputs self;
              flakeConfig = config;
              nixosConfig = nixosArgs.config;
            };

            # make the home manage config for the machine user pairs
            # rename users that are present in the userNames attrs
            # also removes users that don't use home manager
            users = filterHomeManagerConfigs
              (mapAttrs'
                (userName: _:
                  let
                    userConfig = mkHomeManagerConfigModule machine userName;
                  in
                  if userConfig == null
                  then
                    nameValuePair
                      (finalUserName machine userName)
                      null
                  else
                    nameValuePair
                      (finalUserName machine userName)
                      userConfig)
                machine.users);
          };
        });

      # makes a nixos system for a given machine
      mkNixosSystem = machine:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit flakeRoot inputs self;
            flakeConfig = config;
          };

          modules = concatLists [
            machine.nixosModules

            # load role modules out of flake scope
            (map (role: config.roles.${role}) machine.roles)

            (mapAttrsToList
              (_: userModule: nullableAttrs userModule.nixos)
              machine.users)

            [
              machine.hardware
              machine.host.nixos
              machine.extraNixos

              (mkHomeManagerNixosModule machine)

              {
                # set used roles to true on nixos side
                roles = mapAttrs
                  (roleName: _: elem roleName machine.roles)
                  config.roles;

                system.stateVersion = machine.stateVersion;
              }
            ]
          ];
        };
    in
    {
      perSystem = { pkgs, ... }: {
        # make the home manager config for each user on each machine
        # also remove users that do not use home manager
        homeConfiguration = mapAttrs
          (_: machine: filterHomeManagerConfigs
            (mapAttrs (userName: _: mkHomeManagerConfig machine userName pkgs)
              machine.users))
          config.machines;
      };

      flake = {
        inherit (config) machines;

        nixosConfigurations = mapAttrs
          (_: mkNixosSystem)
          config.machines;
      };
    };
}
