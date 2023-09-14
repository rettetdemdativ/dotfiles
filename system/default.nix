{ inputs, lib, config, pkgs, hostname, ... }: {
  imports = [
    (./. + "/${hostname}/boot.nix")
    (./. + "/${hostname}/hardware.nix")
    "${inputs.impermanence}/nixos.nix"
    ./fs.nix
  ] ++ lib.optional (builtins.pathExists (./. + "/${hostname}/extra.nix"))
    (import ./${hostname}/extra.nix {
      config = config;
      pkgs = pkgs;
    });

  nix = {
    package = pkgs.nixFlakes;

    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };

    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  environment.persistence."/persist/system" = {
    directories = [
      "/etc/nixos" # bind mounted from /nix/persist/system/etc/nixos to /etc/nixos
      "/etc/users"
      "/etc/NetworkManager"
      "/etc/ssh"
      "/var/log"
      "/var/lib"
    ];
    files = [ "/etc/nix/id_rsa" ];
  };

  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "95%";
  };

  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp60s0u2u4.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_US.UTF-8";

  services.logind = {
    lidSwitch = "hybrid-sleep";
    lidSwitchDocked = "hybrid-sleep";
    lidSwitchExternalPower = "hybrid-sleep";
    extraConfig = ''
      HandlePowerKey=hybrid-sleep
      HandleSuspendKey=suspend
      HandleHibernateKey=hibernate
      IdleAction=ignore
    '';
  };

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      apply-system = "$HOME/dotfiles/scripts/apply-system.sh";
      update-all = "$HOME/dotfiles/scripts/update.sh";
      clean-generations = "$HOME/dotfiles/scripts/generations-cleanup.sh";
    };
  };

  programs.fuse.userAllowOther = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  security.sudo.extraConfig = ''
    Defaults        lecture = never
  '';
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings = { dns_enabled = true; };
    };

    libvirtd = { enable = false; };
  };

  containers.docker= {
    autoStart = false;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    enableTun = true;
    extraFlags = [ "--private-users-ownership=chown" ];
    additionalCapabilities = [
      # This is a very ugly hack to add the system-call-filter flag to
      # nspawn. extraFlags is written to an env file as an env var and
      # does not support spaces in arguments, so I take advantage of
      # the additionalCapabilities generation to inject the command
      # line argument.
      ''all" --system-call-filter="add_key keyctl bpf" --capability="all''
    ];
    allowedDevices = [
      {
        node = "/dev/fuse";
        modifier = "rwm";
      }
      {
        node = "/dev/mapper/control";
        modifier = "rw";
      }
      {
        node = "/dev/console";
        modifier = "rwm";
      }
    ];
    bindMounts.fuse = {
      hostPath = "/dev/fuse";
      mountPoint = "/dev/fuse";
      isReadOnly = false;
    };
    config = { config, pkgs, ... }: {
      boot.isContainer = true;
      system.stateVersion = "22.11";
      virtualisation.docker.enable = true;
      systemd.services.docker.path = [ pkgs.fuse-overlayfs ];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    pciutils
    zsh
    lm_sensors
    mullvad
    mullvad-vpn
    nvd
  ];

  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "JetBrainsMono" "RobotoMono" ]; }) ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.mullvad-vpn.enable = true;

  users.mutableUsers = false;
  users.users.inet = {
    isNormalUser = true;
    passwordFile = "/persist/etc/users/inet";
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
    packages = [ pkgs.home-manager ];
    shell = pkgs.zsh;
  };
  users.users.root.passwordFile = "/persist/etc/users/root";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

