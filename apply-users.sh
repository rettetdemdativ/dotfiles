#!/bin/sh
pushd ~/dotfiles
home-manager switch -b backup --flake .
popd
