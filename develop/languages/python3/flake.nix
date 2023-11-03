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
        devShell = pkgs.mkShell {
          packages = [ (pkgs.python3.withPackages my-python-packages) ];
        };
      });
}
