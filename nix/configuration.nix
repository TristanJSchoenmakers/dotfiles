# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

let
  secrets = if builtins.pathExists ./secrets.nix
              then import ./secrets.nix
            else {};
  environmentConfig = if secrets.environment == "work"
                        then import ./work.nix
                      else if secrets.environment == "home"
                        then import ./home.nix
                      else {};
  rotateWallpaper = pkgs.writeShellScriptBin "rotate-wallpaper" ''
      #!/usr/bin/env bash
      WALLPAPER=$(find "$HOME/.config/hypr" -maxdepth 1 -type f -iname "*.jpeg" | shuf -n 1)
      /run/current-system/sw/bin/hyprctl hyprpaper preload "$WALLPAPER"
      /run/current-system/sw/bin/hyprctl hyprpaper wallpaper ",$WALLPAPER"
  '';
in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      environmentConfig
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  powerManagement.enable = false;
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true; # Enable networking

  # Set your time zone & internationalisation
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  documentation.nixos.enable = false;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.johndoe = {
    isNormalUser = true;
    description = "johndoe";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];
    xkb.variant = "";
    xkb.layout = "";
  };

  environment.gnome.excludePackages = (with pkgs; [
    epiphany
    evince
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-color-manager
    gnome-connections
    gnome-console
    gnome-contacts
    gnome-font-viewer
    gnome-maps
    gnome-music
    gnome-photos
    gnome-text-editor
    gnome-tour
    gnome-weather
    loupe
    seahorse
    simple-scan
    snapshot
    totem
    geary
  ]);

  environment.sessionVariables = {
    MYENV           = secrets.environment;
    PATH            = [
      "~/.local/share/cargo/bin"
    ];
    # Default Programs
    VISUAL          = "hx";
    EDITOR          = "hx";
    BROWSER         = "brave";
    # XDG Base Directory https://wiki.archlinux.org/title/XDG_Base_Directory#Supported
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_CACHE_HOME  = "$HOME/.cache";
    CARGO_HOME      = "$HOME/.local/share/cargo";
    RUSTUP_HOME     = "$HOME/.local/share/rustup";
    NUGET_PACKAGES  = "$HOME/.local/share/Nuget";
    # GNUPGHOME       = "$HOME/.local/share/gnupg";
    GOPATH          = "$HOME/.local/share/go";
  };

  programs.bash.shellAliases = {
    blui = "bluetoothctl";
    c    = "clear";
    ld   = "sudo lazydocker";
    ls   = "ls --color=auto -a";
    gi   = "gitui";
  };

  programs.bash.shellInit = ''
    function gsync(){
      git add .
      git commit -m update
      git push
    }
    
    function ya() {
        tmp="$(mktemp -t "yazi-cwd.XXXXX")"
        yazi --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }
  '';

  programs.hyprlock.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  networking.firewall.allowedTCPPorts = [ 22 80 443 5900 ];

  virtualisation.docker = {
    enable = true;
    daemon.settings.data-root = "/nix/persist/docker";
    autoPrune.enable = true;
    autoPrune.dates = "weekly";
  };
  programs.starship.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    # display
    hyprpaper
    rotateWallpaper
    hyprshot
      libnotify
      wl-clipboard
    wofi
    waybar
    overskride
    blueman
    wayvnc
    fira-code
    fira-code-nerdfont
    noto-fonts
    # terminal, CLI & TUI's
    alacritty
    yazi
    ueberzugpp
    git
    pinentry-curses
    cloudflared
    gitui
    gh
    lazydocker
    drill
    # Build tools
    rustup
    cargo-nextest
    gcc
    mdbook
    openssl
    # IDE & LSP's
    helix
    vscode-langservers-extracted
    taplo
    clang-tools
    nil
    dprint
    markdown-oxide
    # applications
    brave
    #servo
    remmina
    keepassxc
    mpv-unwrapped
    zathura
  ];

  environment.etc."hosts".text = lib.mkForce ''
    127.0.0.1 localhost
    127.0.0.1       youtube.com
    127.0.0.1       www.youtube.com
    127.0.0.1       9gag.com
    127.0.0.1       www.9gag.com
    
    127.0.0.1       x.com
    127.0.0.1       www.x.com
    127.0.0.1       twitter.com
    127.0.0.1       www.twitter.com
    127.0.0.1       trends24.in
    127.0.0.1       www.trends24.in
    
    127.0.0.1       ad.nl
    127.0.0.1       www.ad.nl
    127.0.0.1       nrc.nl
    127.0.0.1       www.nrc.nl
    127.0.0.1       nu.nl
    127.0.0.1       www.nu.nl
    127.0.0.1       nos.nl
    127.0.0.1       www.nos.nl
    127.0.0.1       telegraaf.nl
    127.0.0.1       www.telegraaf.nl
    127.0.0.1       trouw.nl
    127.0.0.1       www.trouw.nl
    127.0.0.1       volkskrant.nl
    127.0.0.1       www.volkskrant.nl
    127.0.0.1       peilingennederland.nl
    127.0.0.1       www.peilingennederland.nl
    
    127.0.0.1       theguardian.com
    127.0.0.1       www.theguardian.com
    127.0.0.1       cnn.com
    127.0.0.1       www.cnn.com
    127.0.0.1       edition.cnn.com
    127.0.0.1       www.edition.cnn.com
    127.0.0.1       foxnews.com
    127.0.0.1       www.foxnews.com
    127.0.0.1       msnbc.com
    127.0.0.1       www.msnbc.com
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable
  systemd.user.services.hyprpaper-rotate = {
    description = "Rotate Hyprpaper wallpaper once";
    serviceConfig = {
      Type       = "oneshot";
      ExecStart  = "${rotateWallpaper}/bin/rotate-wallpaper";
      # If you only want this after your graphical session is up:
      # After     = "graphical-session.target";
    };
  };
  systemd.user.timers.hyprpaper-rotate = {
    description = "Run hyprpaper-rotate every 30 minutes";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnUnitActiveSec = "30min";
      Persistent      = true;
    };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
