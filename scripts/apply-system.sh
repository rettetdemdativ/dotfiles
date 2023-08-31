#!/bin/sh
pushd ~/dotfiles
sudo nixos-rebuild build --flake .# && nvd diff /run/current-system result && sudo nixos-rebuild switch --flake .#
popd
