{ inputs, lib, config, pkgs, ... }: {
  services.gammastep = {
    enable = true;
    provider = "manual";
    temperature = {
      day = 6000;
      night = 4600;
    };
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
    settings = { general.adjustment-method = "wayland"; };
  };
}
