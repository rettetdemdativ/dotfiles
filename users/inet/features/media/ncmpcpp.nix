{ inputs, lib, config, pkgs, ... }: {
  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = "~/Music";
    settings = {
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "my_fifo";
      visualizer_in_stereo = "yes";
      visualizer_type = "wave";
      visualizer_look = "+|";
    };
  };
}
