{ inputs, lib, config, pkgs, ... }: {
  xdg.configFile."oh-my-custom/simple.zsh-theme".source =
    ../../themes/simple.zsh-theme;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    shellAliases = {
      nix-shell = "nix-shell --command 'zsh'";
      git_relief = "sh $HOME/dotfiles/scripts/git-relief.sh";

      dev_c = "$HOME/dotfiles/scripts/activate-dev.sh languages/c";
      dev_dotnet = "sh $HOME/dotfiles/develop/languages/dotnet/activate.sh";
      dev_go = "$HOME/dotfiles/scripts/activate-dev.sh languages/go";
      dev_java = "$HOME/dotfiles/scripts/activate-dev.sh languages/java";
      dev_java11 = "$HOME/dotfiles/scripts/activate-dev.sh languages/java11";
      dev_nodejs = "$HOME/dotfiles/scripts/activate-dev.sh languages/nodejs";
      dev_perl = "$HOME/dotfiles/scripts/activate-dev.sh languages/perl";
      dev_python = "$HOME/dotfiles/scripts/activate-dev.sh languages/python3";
      dev_rust = "$HOME/dotfiles/scripts/activate-dev.sh languages/rust";
      dev_typst = "$HOME/dotfiles/scripts/activate-dev.sh languages/typst";
      dev_aws = "$HOME/dotfiles/scripts/activate-dev.sh stacks/aws";
      dev_azure = "$HOME/dotfiles/scripts/activate-dev.sh stacks/azure";
      dev_zed = "nix-shell $HOME/dotfiles/develop/tools/zed";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "gpg-agent" ];

      custom = "$HOME/.config/oh-my-custom";
      theme = "simple";
    };
  };
}
