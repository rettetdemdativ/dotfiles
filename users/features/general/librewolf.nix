{ inputs, lib, config, pkgs, username, ... }: {
  programs.librewolf = {
    enable = true;
    settings = {
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;
      "browser.tabs.groups.enabled" = true;
      "privacy.resistFingerprinting.letterboxing" = true;
    };
  };

  home.persistence."/persist" = {
    directories = [ ".librewolf" ];
  };
}
