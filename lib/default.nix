{ inputs, outputs, nixpkgs, agenix, stateVersion, ... }:
let
  helpers = import ./helpers.nix { inherit inputs outputs nixpkgs agenix stateVersion; };
in
{
  mkHome = helpers.mkHome;
  mkHost = helpers.mkHost;
  forAllSystems = helpers.forAllSystems;
}
