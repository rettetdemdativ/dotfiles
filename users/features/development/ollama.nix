{ inputs, lib, config, pkgs, username, ... }: {
  home.persistence."/persist" = {
    directories = [ ".ollama" ];
  };

  services.ollama = { enable = true; };
}
