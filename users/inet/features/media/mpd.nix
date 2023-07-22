{ inputs, lib, config, pkgs, ... }: {
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";

    network = { startWhenNeeded = true; };

    extraConfig = ''
      pid_file           "~/.config/mpd/pid"
      state_file         "~/.config/mpd/state"
      sticker_file       "~/.config/mpd/sticker.sql"
      audio_buffer_size "4096"
      max_output_buffer_size "16384"
      audio_output {
          type  "pulse"
          name  "pulseaudio"
      }

      audio_output {  
          type               "fifo"  
          name               "my_fifo"
          path               "/tmp/mpd.fifo"
          format             "44100:16:2"
      }
    '';
  };
}
