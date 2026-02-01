{ outputs, inputs }:
let
  addPatches =
    pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or [ ]) ++ patches;
    });
in
rec {
  modifications = final: prev: {
    #bindfs = inputs.nixpkgs-master.legacyPackages.${final.system}.bindfs;
  };
}
