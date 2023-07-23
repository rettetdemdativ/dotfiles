{ inputs, outputs, nixpkgs, disko, stateVersion, ... }: {
  mkHome = { username, platform ? "x86_64-linux" }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = platform;
        config = { allowUnfree = true; };
      };
      extraSpecialArgs = {
        inherit inputs outputs platform username stateVersion;
      };
      modules = [ ../users ];
    };

  mkHost = { hostname, disk, installer ? null }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs outputs hostname stateVersion; };
      modules = [ 
        disko.nixosModules.disko
        ../system/disko.nix
        {
          _module.args.disks = [ disk ];
        }
        ../system 
      ]
        ++ (inputs.nixpkgs.lib.optionals (installer != null) [ installer ]);
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}

