{
  description = "Java development environment";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      # Systems supported
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      # Helper to provide system-specific attributes
      forAllSystems = f:
        nixpkgs.lib.genAttrs allSystems
        (system: f { pkgs = import nixpkgs { inherit system; }; });
    in {
      devShells = forAllSystems ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            jdk11
            maven
            gradle
            kotlin
            zlib
            ncurses
            freetype # for missing libfreetype.so.6 ];
          ];
          shellHook = ''
            export JAVA_HOME=${pkgs.jdk11}/lib/openjdk
            PATH="${pkgs.jdk11}/bin:$PATH"
          '';
        };
      });
    };
}
