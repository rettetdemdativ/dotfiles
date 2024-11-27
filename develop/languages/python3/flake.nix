{
  description = "Python development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, mach-nix, ... }@attr:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        my-python-packages = ps: with ps; [ virtualenv ];
        my-python = pkgs.python3.withPackages my-python-packages;
      in {
        devShell = pkgs.mkShell rec {
          buildInputs = [ pkgs.python3 pkgs.zlib pkgs.pylint pkgs.black ];
          packages =
            [ (pkgs.python3.withPackages my-python-packages) pkgs.zlib pkgs.ruff ];
          shellHook = ''
            export LD_LIBRARY_PATH="${
              pkgs.lib.makeLibraryPath buildInputs
            }:$LD_LIBRARY_PATH"
            export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib.outPath}/lib:$LD_LIBRARY_PATH"
          '';
        };
      });
}
