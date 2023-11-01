{ inputs, outputs, nixpkgs, stateVersion, ... }:
let
  helpers =
    import ./helpers.nix { inherit inputs outputs nixpkgs stateVersion; };
in {
  mkHost = helpers.mkHost;
  forAllSystems = helpers.forAllSystems;
}
