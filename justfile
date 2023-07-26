set shell := [ "fish", "-c" ]

alias t := test-all
alias test := test-all
alias tan := test-all-nixos
alias tah := test-all-home-manager
alias tn := test-nixos
alias th := test-home-manager

hosts := "hydrogen,odyssey,quantum"
users := "jeff@hydrogen,jeff@odyssey,jeff@quantum"

# list the currently available just recipes
default:
    @just --list

# run all build tests for everything
test-all: test-all-nixos test-all-home-manager

# run build tests for all NixOS systems
test-all-nixos:
    #! /run/current-system/sw/bin/fish
    set hosts (string split , -- {{hosts}});
    for host in $hosts;
        just test-nixos $host;

        if test $status -ne 0;
            exit 1
        end
    end

# run build tests for all Home Manager activations
test-all-home-manager:
    #! /run/current-system/sw/bin/fish
    set users (string split , -- {{users}});
    for user in $users;
        set host (string split @ -- $user);

        just test-home-manager $host[1] $host[2];

        if test $status -ne 0;
            exit 1
        end
    end

# run build test for a specific NixOS system
test-nixos host:
    nix build .#nixosConfigurations.{{host}}.config.system.build.toplevel --dry-run

# run build test for a specific Home Manager activation
test-home-manager user host:
    nix build .#homeConfigurations.{{user}}@{{host}}.activationPackage --dry-run

# rebuild and switch to new system
switch:
    sudo nixos-rebuild switch

# rebuild and test new system without boot entry
try:
    sudo nixos-rebuild test
