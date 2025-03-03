#!/bin/bash

pushd ~/dotfiles/hosts/no_nixos
home-manager switch --flake .#${USER}
popd
