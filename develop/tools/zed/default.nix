{ pkgs ? import <nixpkgs> {} }:

(pkgs.buildFHSEnv {
    name = "zed";
    runScript = "zeditor .";
}).env
