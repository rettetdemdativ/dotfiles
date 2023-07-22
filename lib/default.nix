{ inputs, outputs, nixpkgs, stateVersion, ... }:
let
  helpers = import ./helpers.nix { inherit inputs outputs nixpkgs stateVersion; };
in
{
  mkHome = helpers.mkHome;
  mkHost = helpers.mkHost;
  forAllSystems = helpers.forAllSystems;
}
