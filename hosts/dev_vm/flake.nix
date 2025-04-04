{
  description = "Dev VM configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

   home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      username = "mkoeppl";
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      homeConfigurations = {
        mkoeppl = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ../../users/dev_vm ];
          extraSpecialArgs = { inherit inputs username; };
          extraSpecialArgs.flake-inputs = inputs;
        };
      };
    };
}
