{ inputs, outputs, pkgs, stateVersion, ... }: {
  mkHost =
    { hostname, username, platform ? "x86_64-linux", disk, installer ? null }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs outputs hostname username stateVersion; };
      modules = [
        inputs.disko.nixosModules.disko
        ../system/${hostname}/disko.nix
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
            inherit inputs outputs pkgs hostname username stateVersion;
          };
          home-manager.extraSpecialArgs.flake-inputs = inputs;
        }
        inputs.nix-ld.nixosModules.nix-ld
        inputs.niri.nixosModules.niri
        ../system
      ] ++ (inputs.nixpkgs.lib.optionals (installer != null) [ installer ]);
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "x86_64-linux"
  ];
}
