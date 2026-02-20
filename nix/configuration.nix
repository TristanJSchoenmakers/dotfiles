# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:

let
  personal = if builtins.pathExists ./personal.nix then import ./personal.nix else {};
in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./desktop.nix
      ./modules/trash.nix
      personal
    ];

  # Use the systemd-boot EFI boot loader.
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

  services.printing.enable = true;
  services.pipewire.enable = true;
  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.johndoe = {
    isNormalUser = true;
    description = "johndoe";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
  };

  environment.sessionVariables = {
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
    GNUPGHOME       = "$HOME/.local/share/gnupg";
    GOPATH          = "$HOME/.local/share/go";
    GRADLE_USER_HOME= "$XDG_DATA_HOME/gradle";
    DOCKER_CONFIG   = "$XDG_CONFIG_HOME/docker";
    KUBECONFIG      = "$XDG_CONFIG_HOME/kube";
    KUBECACHEDIR    = "$XDG_CACHE_HOME/kube";
    MACHINE_STORAGE_PATH = "$XDG_DATA_HOME/docker-machine";
  };

  environment.shellAliases = {
    blui = "bluetoothctl";
    c    = "clear";
    ld   = "sudo lazydocker";
    ls   = "ls --color=auto -a";
    gi   = "gitui";
  };

  programs.bash.interactiveShellInit = ''
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

  programs.chromium = {
    enable = true;
    extraOpts = {
      "BraveAIChatEnabled" = false;
      "BraveNewsDisabled" = true;
      "BraveRewardsDisabled" = true;
      "BraveStatsPingEnabled" = false;
      "BraveWalletDisabled" = true;
      "BrowserSignin" = false;
      "PasswordManagerEnabled" = false;
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 80 443 5900 ];

  virtualisation.docker = {
    enable = true;
    daemon.settings.data-root = "/nix/persist/docker";
    autoPrune.enable = true;
    autoPrune.dates = "weekly";
  };
  programs.starship = {
    enable = true;
    settings.package.disabled = true;
    settings.git_branch.symbol = " ";
    settings.git_status.stashed = "";
  };
  programs.git.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    # Terminal
    alacritty
    ueberzugpp
    # CLI's
    ripgrep
    pinentry-curses
    cloudflared
    wayvnc
    imagemagick
    ffmpeg_7-headless
    # TUI's
    yazi
    gitui
    gh
    lazydocker
    drill
    # Build tools
    rustup
    cargo-nextest
    gcc
    lld_21
    mdbook
    openssl
    pkg-config
    # IDE & LSP's
    helix
    vscode-langservers-extracted
    typescript-language-server
    clang-tools
    nil
    dprint
    markdown-oxide
    # applications
    # nextdns
    brave
    mpv-unwrapped
  ];

  environment.variables = {
    PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig";
  };


  # networking.nameservers = [ "127.0.0.1" "::1" ];
  #networking.networkmanager.dns = "none";
  #services.resolved.enable = false;
  #services.nextdns = {
  #  enable = true;
  #  arguments = [  "-config" secrets.nextDnsId "-cache-size" "10MB" "-report-client-info" "-discovery-dns" secrets.environment ];
  #};
      
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
