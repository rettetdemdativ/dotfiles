{ inputs, lib, config, pkgs, username, ... }: {
  services.mpd = {
    enable = true;
    musicDirectory = "/home/${username}/Music";
    network = {
      listenAddress = "127.0.0.1";
      port = 6601;
      #startWhenNeeded = true; 
    };
    extraConfig = ''
      audio_buffer_size "4096"
      max_output_buffer_size "16384"

      audio_output {  
        type               "pipewire"  
        name               "PipeWire_Output"
      }
    '';
  };
}
