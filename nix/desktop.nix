{ pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
    xkb.variant = "";
    xkb.layout = "";
  };
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

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
    papers
    seahorse
    showtime
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

  # Cursor / theme fix: https://wiki.hypr.land/Nix/Hyprland-on-NixOS/#fixing-problems-with-themes & https://wiki.hypr.land/Hypr-Ecosystem/hyprcursor/
  environment.sessionVariables = {
    XCURSOR_THEME   = "Adwaita";
    XCURSOR_SIZE    = 24;
    HYPRCURSOR_SIZE = 24;
  };

  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita";
        icon-theme = "Flat-Remix-Red-Dark";
        font-name = "Noto Sans Medium 11";
        # cursor-size = lib.gvariant.mkInt32 64;
        document-font-name = "Noto Sans Medium 11";
        monospace-font-name = "Noto Sans Mono Medium 11";
      };
    }
  ];

  environment.systemPackages = with pkgs; [
    # display
    hyprpaper
    hyprshot
      libnotify
      wl-clipboard
    wofi
    waybar
    eww
    pamixer
  ];
}
