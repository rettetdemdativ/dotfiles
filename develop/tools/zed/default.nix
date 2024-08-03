{ pkgs ? import <nixpkgs> {} }:

(pkgs.buildFHSEnv {
    name = "zed";
    runScript = "zed .";
}).env
