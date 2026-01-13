{ inputs, lib, config, pkgs, username, ... }: {
  home.persistence."/persist/home/${username}" = {
    directories = [ ".ollama" ];
  };

  services.ollama = { enable = true; };
}
