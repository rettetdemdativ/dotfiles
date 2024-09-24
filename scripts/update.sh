#!/bin/sh
pushd ~/dotfiles/hosts/"$HOSTNAME"
nix flake update
popd
