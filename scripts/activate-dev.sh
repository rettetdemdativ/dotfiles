#!/bin/sh
pushd ~/dotfiles/develop/$1
nix develop -c $SHELL
popd
