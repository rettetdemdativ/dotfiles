{ inputs, lib, config, pkgs, username, ... }: {
  programs.librewolf = {
    enable = true;
    settings = {
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;
      "privacy.resistFingerprinting.letterboxing" = true;
    };
  };

  home.persistence."/persist/home/${username}" = {
    directories = [ ".librewolf" ];
  };
}
