#!/bin/sh
pushd ~/dotfiles
nixos-rebuild build --flake .#$HOST && nvd diff /run/current-system result && doas nixos-rebuild switch --flake .#$HOST
popd
