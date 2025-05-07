{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence/master";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    niri.url = "github:sodiboo/niri-flake";
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, disko, home-manager, nixos-hardware, ... }:
    let
      inherit (self) outputs;
      stateVersion = "23.05";
      libx = import ../../lib { inherit inputs outputs nixpkgs stateVersion; };
    in {
      nixosConfigurations = {
        nixfw = libx.mkHost {
          hostname = "nixfw";
          username = "inet";
          disk = "/dev/nvme0n1";
        };
      };
    };
}
