{ inputs, lib, config, pkgs, ... }: {
  xdg.configFile."oh-my-custom/simple.zsh-theme".source =
    ../../themes/simple.zsh-theme;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    shellAliases = {
      nix-shell = "nix-shell --command 'zsh'";
      monitor_laptop = "sh $HOME/.config/hypr/apply_monitor_setup.sh laptop";
      monitor_home = "sh $HOME/.config/hypr/apply_monitor_setup.sh home";
      monitor_mirror = "sh $HOME/.config/hypr/apply_monitor_setup.sh mirror";
      git_relief = "sh $HOME/dotfiles/scripts/git-relief.sh";

      dev_c = "$HOME/dotfiles/scripts/activate-dev.sh languages/c";
      dev_dotnet = "$HOME/dotfiles/scripts/activate-dev.sh languages/dotnet";
      dev_go = "$HOME/dotfiles/scripts/activate-dev.sh languages/go";
      dev_java = "$HOME/dotfiles/scripts/activate-dev.sh languages/java";
      dev_java11 = "$HOME/dotfiles/scripts/activate-dev.sh languages/java11";
      dev_nodejs = "$HOME/dotfiles/scripts/activate-dev.sh languages/nodejs";
      dev_python = "$HOME/dotfiles/scripts/activate-dev.sh languages/python3";
      dev_rust = "$HOME/dotfiles/scripts/activate-dev.sh languages/rust";
      dev_aws = "$HOME/dotfiles/scripts/activate-dev.sh stacks/aws";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "gpg-agent" ];

      custom = "$HOME/.config/oh-my-custom";
      theme = "simple";
    };
  };
}
