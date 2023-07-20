#!/bin/sh
nix develop "$HOME/dotfiles/develop/$1" -c "$SHELL"
