#!/bin/sh
pushd ~/dotfiles
mkdir -p ~/.local/state/nix/profiles
home-manager switch -b backup --flake .
popd
