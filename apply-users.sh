#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/inet/home.nix
popd
