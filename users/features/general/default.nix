{ inputs, lib, config, pkgs, ... }: { imports = [ ./chromium.nix ./firefox.nix ]; }
