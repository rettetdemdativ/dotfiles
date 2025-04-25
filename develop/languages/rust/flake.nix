{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, fenix, flake-utils, }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        devToolchain = fenix.packages."${system}".stable;
      in rec {
        devShell = pkgs.mkShell {
          nativeBuildInputs = [
            (devToolchain.withComponents [
              "cargo"
              "rustc"
              "rust-src"
              "rustfmt"
              "clippy"
              "rust-analyzer"
            ])
          ];
          shellHook = ''
            export PATH=$PATH:~/.cargo/bin
          '';
          RUST_BACKTRACE = 1;
        };
      });
}

