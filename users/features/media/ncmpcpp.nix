{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.ncmpcpp = {
    enable = true;
    settings = {
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "my_fifo";
      visualizer_in_stereo = "yes";
      visualizer_type = "wave";
      visualizer_look = "+|";
      mpd_host = "127.0.0.1";
      mpd_port = 6601;
    };
  };
}
