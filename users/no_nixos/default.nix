{ inputs, config, pkgs, username, nixgl, ... }:
let
in rec {
  imports = [
    #inputs.niri.homeModules.niri
    ../features/desktop
    ../features/development
    ../features/general
    ../features/media
    ../features/cli
  ];

  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.installScripts = [ "mesa" ];

  programs.ghostty.package = with pkgs; (config.lib.nixGL.wrap ghostty);

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  nixpkgs.config = {
    allowUnfree = true;
    # Workaround for https://github.com/nix-community/home-manager/issues/2942
    allowUnfreePredicate = (_: true);
  };

  #programs.niri = {
  #  enable = true;
  #  package = with pkgs; (config.lib.nixGL.wrap niri);
  #};

  home.packages = with pkgs; [ rustup ];

  home.sessionVariables = rec { EDITOR = "nvim"; };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "zathura.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "image/png" = [ "imv.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "application/x-extension-htm" = [ "firefox.desktop" ];
      "application/x-extension-html" = [ "firefox.desktop" ];
      "application/x-extension-shtml" = [ "firefox.desktop" ];
      "application/x-extension-xht" = [ "firefox.desktop" ];
      "application/x-extension-xhtml" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];

      "video/webm" = [ "mpv.desktop" ];
      "video/ogg" = [ "mpv.desktop" ];
      "video/x-msvideo" = [ "mpv.desktop" ];
      "video/x-flv" = [ "mpv.desktop" ];
      "video/mp4" = [ "mpv.desktop" ];

      "inode/directory" = [ "nnn.desktop" "nautilus.desktop" ];
    };
  };
}
