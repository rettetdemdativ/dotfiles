{ inputs, lib, config, pkgs, ... }: {
    programs.chromium = {
        enable = true;
    };
}
