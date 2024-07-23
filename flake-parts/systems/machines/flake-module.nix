{ config, inputs, lib, self, ... }:
let
  inherit (lib)
    any
    concatLists
    filterAttrs
    id
    mapAttrs
    mapAttrsToList
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

          roles = mkOption {
            type = listOf deferredModule;
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

      # makes a home manager module for a machine username pair's config
      # returns a home manager module or null if not needed
      mkHomeManagerConfigModule = machine: userName:
        if !(userNeedsHomeManager machine userName)
        then null
        else {
          imports = [
            # shared modules
            (nullableAttrs machine.host.homeManager)
            (nullableAttrs machine.extraHomeManager)

            {
              imports = machine.homeModules;
              home.stateVersion = machine.stateVersion;
            }

            # # user modules
            (nullableAttrs machine.users.${userName}.homeManager)

            {
              programs.home-manager.enable = true;

              home = {
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
            extraSpecialArgs = { inherit inputs self; };

            modules = [ (nullableAttrs (mkHomeManagerConfigModule machine userName)) ];
          };


      # checks if a machine or any of its users needs home manager
      nixosNeedsHomeManager = machine: any id
        (mapAttrsToList (userName: _: userNeedsHomeManager machine userName)
          machine.users);

      # makes a nixos module to load home manager
      # returns an empty attrs if the machine does not use hm
      mkHomeManagerNixosModule = machine: optionalAttrs
        (nixosNeedsHomeManager machine)
        {
          imports = [ inputs.home-manager.nixosModules.home-manager ];

          # configure home-manager in nixos scope
          home-manager = {
            extraSpecialArgs = { inherit inputs self; };
            useGlobalPkgs = true;
            useUserPackages = true;

            # make the home manage config for the machine user pairs
            # also removes users that don't use home manager
            users = filterHomeManagerConfigs
              (mapAttrs
                (userName: _:
                  let
                    userConfig = mkHomeManagerConfigModule machine userName;
                  in
                  if userConfig == null
                  then null
                  else userConfig)
                machine.users);
          };
        };

      # makes a nixos system for a given machine
      mkNixosSystem = machine:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs self; };

          modules = concatLists [
            machine.nixosModules
            machine.roles

            (mapAttrsToList
              (_: userModule: nullableAttrs userModule.nixos)
              machine.users)

            [
              machine.hardware
              machine.host.nixos
              machine.extraNixos

              (mkHomeManagerNixosModule machine)

              { system.stateVersion = machine.stateVersion; }
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
