{ inputs, lib, config, pkgs, ... }: {
  programs.librewolf = {
    enable = true;
    settings = {
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;
      #"privacy.resistFingerprinting.letterboxing" = true;
    };
  };
}
