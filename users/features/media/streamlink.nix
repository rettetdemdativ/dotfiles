{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:
{
  programs.streamlink = {
    enable = true;
    settings = {
      player = "${pkgs.mpv}/bin/mpv";
    };
  };
}
