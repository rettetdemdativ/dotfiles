{
  inputs,
  outputs,
  pkgs,
  stateVersion,
  ...
}:
let
  helpers = import ./helpers.nix {
    inherit
      inputs
      outputs
      pkgs
      stateVersion
      ;
  };
in
{
  mkHost = helpers.mkHost;
  forAllSystems = helpers.forAllSystems;
}
