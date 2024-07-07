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
    hyprland.url = "github:hyprwm/Hyprland";
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = { self, nixpkgs, disko, home-manager, nixos-hardware, ... }@inputs:
    let
      inherit (self) outputs;
      stateVersion = "23.05";
      libx = import ./lib { inherit inputs outputs nixpkgs stateVersion; };
    in {
      # home-manager switch -b backup --flake $HOME/.config/nix-config
      # nix build .#homeConfigurations."username@host".activationPackage
      homeConfigurations = {
        "inet" = libx.mkHome {
          username = "inet";
          platform = "x86_64-linux";
        };
        "rettetdemdativ" = libx.mkHome {
          username = "rettetdemdativ";
          platform = "x86_64-linux";
        };
      };

      nixosConfigurations = {
        # sudo nixos-rebuild switch --flake .#
        nixxps = libx.mkHost {
          hostname = "nixxps";
          username = "inet";
          disk = "/dev/nvme0n1";
        };
        nixbox = libx.mkHost {
          hostname = "nixbox";
          username = "rettetdemdativ";
          disk = "/dev/nvme0n1";
        };
      };
    };
}
