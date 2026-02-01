{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  services.mako = {
    enable = true;
    settings = {
      background-color = "#000000";
      border-color = "#ffffff";
      default-timeout = 3000;
      font = "Roboto 10";
    };
  };
}
