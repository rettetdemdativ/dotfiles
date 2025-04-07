#!/bin/bash
pushd ~/dotfiles/hosts/dev_vm
nix flake update
popd
