{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];
    xkb.variant = "";
    xkb.layout = "";
  };

  fonts.packages = with pkgs; [
    fira-code
    nerd-fonts.fira-code
    noto-fonts
  ];

  # Gnome
  environment.gnome.excludePackages = (with pkgs; [
    epiphany
    evince
    decibels
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

  # Hyprland
  programs.hyprlock.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # display
    hyprpaper
    hyprshot
      libnotify
      wl-clipboard
    wofi
    waybar
    blueman
  ];
}
