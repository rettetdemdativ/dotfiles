#!/bin/sh
pushd ~/dotfiles
doas nixos-rebuild build --flake .# && nvd diff /run/current-system result && doas nixos-rebuild switch --flake .#
popd
