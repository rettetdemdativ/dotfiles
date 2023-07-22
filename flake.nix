{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, agenix, home-manager, nixos-hardware, ... }@inputs:
    let
      inherit (self) outputs;
      stateVersion = "23.05";
      libx =
        import ./lib { inherit inputs outputs nixpkgs agenix stateVersion; };
    in {
      # home-manager switch -b backup --flake $HOME/.config/nix-config
      # nix build .#homeConfigurations."username@host".activationPackage
      homeConfigurations = {
        "inet" = libx.mkHome {
          username = "inet";
          platform = "x86_64-linux";
        };
      };

      nixosConfigurations = {
        # sudo nixos-rebuild switch --flake .#
        nixxps = libx.mkHost { hostname = "nixxps"; };
      };
    };
}
