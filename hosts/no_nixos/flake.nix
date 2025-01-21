{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations = {
        inet = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          #configuration = (import ../../users/no_nixos {username="inet";});
          modules = [ (../../users/no_nixos { username = "inet"; }) ];
        };
      };
    };
}
