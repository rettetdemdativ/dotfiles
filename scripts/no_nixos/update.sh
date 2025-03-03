#!/bin/bash
pushd ~/dotfiles/hosts/no_nixos
nix flake update
popd
