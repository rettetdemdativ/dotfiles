#!/bin/sh
pushd ~/dotfiles/hosts/"$HOSTNAME"
sudo nix flake update
popd
