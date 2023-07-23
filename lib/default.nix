{ inputs, outputs, nixpkgs, disko, stateVersion, ... }:
let
  helpers = import ./helpers.nix {
    inherit inputs outputs nixpkgs disko stateVersion;
  };
in {
  mkHome = helpers.mkHome;
  mkHost = helpers.mkHost;
  forAllSystems = helpers.forAllSystems;
}
