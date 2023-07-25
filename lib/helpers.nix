{ inputs, outputs, nixpkgs, stateVersion, ... }: {
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

  mkHost = { hostname, username, platform ? "x86_64-linux", disk, installer ? null }:
    inputs.nixpkgs.lib.nixosSystem {
      pkgs = import nixpkgs {
        system = platform;
        config = { allowUnfree = true; };
      };
      specialArgs = { inherit inputs outputs hostname username stateVersion; };
      modules = [
        inputs.disko.nixosModules.disko
        ../system/disko.nix
        { _module.args.disks = [ disk ]; }
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ../users;

          home-manager.extraSpecialArgs = {
            inherit inputs outputs hostname username stateVersion;
          };
        }
        ../system
      ] ++ (inputs.nixpkgs.lib.optionals (installer != null) [ installer ]);
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}

