#!/bin/bash

podman build -t vscode-dotnet:latest -f $HOME/dotfiles/develop/languages/dotnet/Dockerfile $HOME/dotfiles/develop/languages/dotnet

distrobox create -i vscode-dotnet:latest -n vscode-dotnet --home "$HOME/workspace/vscode"

TERM=xterm-256color distrobox enter vscode-dotnet
