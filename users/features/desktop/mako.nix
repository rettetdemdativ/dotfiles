{ inputs, lib, config, pkgs, ... }: {
  services.mako = {
    enable = true;
    backgroundColor = "#000000";
    borderColor = "#ffffff";
    defaultTimeout = 3000;
    font = "Roboto 10";
  };
}
