{ inputs, lib, config, pkgs, username, ... }: {
  programs.librewolf = {
    enable = true;
    settings = {
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;
      "privacy.resistFingerprinting" = false;
      "browser.tabs.groups.enabled" = true;
    };
  };
}
