_: { config, inputs, lib, self, ... }:
let
  inherit (builtins)
    attrNames
    length
    mapAttrs
    ;

  inherit (lib)
    mkOption
    types
    ;
in
{
  options = {
    machines = mkOption {
      type = with types; attrsOf (submodule {
        options = {
          homeModules = mkOption {
            type = with types; listOf deferredModule;
            default = [ config.flake.homeModules.default ];
          };

          nixosModules = mkOption {
            type = with types; listOf deferredModule;
            default = [ config.flake.nixosModules.default ];
          };

          hardware = mkOption {
            type = types.deferredModule;
          };

          host = mkOption {
            type = types.submodule {
              options = {
                homeManager = mkOption {
                  type = deferredModule;
                  default = { };
                };

                nixos = mkOption {
                  type = deferredModule;
                  default = { };
                };
              };
            };
          };

          users = mkOption {
            type = with types; attrsOf (listOf deferredModule);
            default = { };
          };

          roles = mkOption {
            type = with types; listOf deferredModule;
            default = [ ];
          };

          extraHomeManager = mkOption {
            type = types.deferredModule;
            default = { };
          };

          extraNixos = mkOption {
            type = types.deferredModule;
            default = { };
          };

          stateVersion = mkOption {
            type = types.str;
          };
        };
      });
    };
  };

  config =
    let
      mkHomeManagerModule = machine:
        if length (attrNames machine.users) > 0 then
          {
            imports = [ inputs.home-manager.nixosModules.home-manager ];

            home-manager = {
              extraSpecialArgs = { inherit inputs self; };
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                machine.host.homeManager
                machine.extraHomeManager
                { home.stateVersion = machine.stateVersion; }
              ] ++ machine.homeModules;
              users = mapAttrs
                (uname: userModules: {
                  home = rec {
                    username = uname;
                    homeDirectory = lib.mkDefault "/home/${username}";
                  };

                  imports = userModules;
                  programs.home-manager.enable = true;
                })
                machine.users;
            };
          }
        else
          { };

      mkNixosConfig = machine: attrs:
        inputs.nixpkgs.lib.nixosSystem ({
          specialArgs = { inherit inputs self; };
          modules = with machine;
            [
              hardware
              host.nixos
              (mkHomeManagerModule machine)
              machine.extraNixos
              { system.stateVersion = machine.stateVersion; }
              ../common.nix
            ]
            ++ nixosModules
            ++ roles;
        } // attrs);
    in
    {
      perSystem = { pkgs, system, ... }: lib.mkMerge (builtins.attrValues (mapAttrs
        (name: machine: {
          homeConfiguration.${name} = mapAttrs
            (uname: userModules:
              inputs.home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = { inherit inputs self; };
                modules =
                  [
                    machine.extraHomeManager
                    machine.host.homeManager
                    {
                      home = rec {
                        username = uname;
                        homeDirectory = lib.mkDefault "/home/${username}";
                        stateVersion = machine.stateVersion;
                      };
                    }
                  ]
                  ++ machine.homeModules
                  ++ userModules;
              })
            machine.users;

          nixosConfiguration.${name} = mkNixosConfig machine { inherit system; };
        })
        config.machines));

      flake = {
        inherit (config) machines;

        nixosConfigurations = mapAttrs
          (_: machine: mkNixosConfig machine { })
          config.machines;
      };
    };
}
