#!/bin/sh
pushd ~/.dotfiles
nix run . -- build --flake .
./result/activate
popd
