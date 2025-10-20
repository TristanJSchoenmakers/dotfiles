# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./home-manager.nix
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

  # nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-connections
    gnome-console
    gnome-text-editor
  ]) ++ (with pkgs.gnome; [
    cheese      # photo booth
    eog         # image viewer
    epiphany    # web browser
    gedit       # text editor
    simple-scan # document scanner
    totem       # video player
    yelp        # help viewer
    evince      # document viewer
    seahorse    # password manager
    gnome-terminal gnome-logs gnome-characters gnome-clocks gnome-contacts
    gnome-font-viewer gnome-calculator gnome-maps gnome-music gnome-weather 
  ]);

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable gnome RDP
  services.gnome.gnome-remote-desktop.enable = true;
  networking.firewall.allowedTCPPorts = [ 3389 ];

  programs.starship.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.johndoe = {
    isNormalUser = true;
    description = "johndoe";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
    # system
    # home-manager
    # display
    hyprpaper
    rofi-wayland
    fira-code
    fira-code-nerdfont
    noto-fonts
    # bar
    eww-wayland
    socat
    jq
    python3
    # terminal
    alacritty
    lf
    bat
    glow
    git
    gitui
    gh
    # Programming language build tools
    rustup
    gcc
    dotnet-sdk_8
    dotnet-aspnetcore_8
    xorg.libX11
    xorg.libXi
    libGL
    # IDE & LSP's
    helix
    jetbrains.rider
    vscode-langservers-extracted
    nil
    omnisharp-roslyn
    netcoredbg
    # applications
    brave
    remmina
    qbittorrent-qt5
    mpv-unwrapped
    discord
  ];

  environment.variables.LD_LIBRARY_PATH = builtins.concatStringsSep ":" [
    "${pkgs.xorg.libX11}/lib"
    "${pkgs.xorg.libXi}/lib"
    "${pkgs.libGL}/lib"
  ];

  # home-manager = {
    # extraSpecialArgs = { inherit inputs; };
    # users = {
      # janedoe = import ./home.nix;
    # };
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
