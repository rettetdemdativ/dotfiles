{ inputs, outputs, nixpkgs, stateVersion, ... }: {
  mkHost =
    { hostname, username, platform ? "x86_64-linux", disk, installer ? null }:
    inputs.nixpkgs.lib.nixosSystem {
      pkgs = import nixpkgs {
        system = platform;
        config = { allowUnfree = true; };
      };
      specialArgs = { inherit inputs outputs hostname username stateVersion; };
      modules = [
        inputs.disko.nixosModules.disko
        ../system/disko.nix
        {
          _module.args.disks = [ disk ];
          _module.args.usernames = [ username ];
        }
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ../users;

          home-manager.extraSpecialArgs = {
            inherit inputs outputs hostname username stateVersion;
          };
          home-manager.extraSpecialArgs.flake-inputs = inputs;
        }
        inputs.niri.nixosModules.niri
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
