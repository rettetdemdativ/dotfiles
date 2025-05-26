{ inputs, lib, config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    plugins = with pkgs; [ tmuxPlugins.yank tmuxPlugins.tmux-which-key ];
    extraConfig = ''
      set -g status-style bg=default
      set -g default-terminal "xterm-kitty"
      set -g terminal-overrides "xterm-kitty"
      # true colours support
      # set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      # underscore colours - needs tmux-3.0
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
    '';
  };
}
