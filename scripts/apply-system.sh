#!/bin/sh

pushd ~/dotfiles/hosts/"$HOSTNAME"
nixos-rebuild build --flake .#$HOST && nvd diff /run/current-system result && sudo nixos-rebuild switch --flake .#$HOST
popd
