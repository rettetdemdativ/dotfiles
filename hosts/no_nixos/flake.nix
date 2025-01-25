{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url =
      "github:nix-community/nixGL"; # Necessary to run GL software on non-NixOS systems
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixgl, ... }:
    let
      username = "inet";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nixgl.overlay ];
      };
    in {
      homeConfigurations.${username} =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ../../users/no_nixos ];
          extraSpecialArgs = { inherit inputs username; };
          extraSpecialArgs.flake-inputs = inputs;
        };
    };
}
