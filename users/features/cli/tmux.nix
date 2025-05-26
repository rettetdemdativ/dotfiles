{ inputs, lib, config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    plugins = with pkgs; [ tmuxPlugins.yank tmuxPlugins.tmux-which-key ];
    extraConfig = ''
      set -g status-style bg=default
    '';
  };
}
