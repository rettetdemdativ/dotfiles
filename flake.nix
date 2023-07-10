{
  description = "NixOS config";
 
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;
  in {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

    homeConfigurations = {
      inet = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;

	modules = [ ./users/inet/home.nix ];
      };
    };

    nixosConfigurations = {
      nixxps = lib.nixosSystem {
        inherit system;

	modules = [
	  ./system/configuration.nix
	  nixos-hardware.nixosModules.dell-xps-13-9380
	];
      };
    };
  };
}
