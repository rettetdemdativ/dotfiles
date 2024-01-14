{ inputs, lib, config, pkgs, username, ... }: {
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    network = { startWhenNeeded = true; };
    extraConfig = ''
      bind_to_address    "~/.config/mpd/socket"
      pid_file           "~/.config/mpd/pid"
      state_file         "~/.config/mpd/state"
      sticker_file       "~/.config/mpd/sticker.sql"

      audio_buffer_size "4096"
      max_output_buffer_size "16384"

      audio_output {  
          type               "pipewire"  
          name               "PipeWire_Output"
      }
    '';
  };
}
