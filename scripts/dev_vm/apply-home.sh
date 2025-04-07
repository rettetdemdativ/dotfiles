#!/bin/bash

pushd ~/dotfiles/hosts/dev_vm
home-manager switch --flake .#${USER}
popd
