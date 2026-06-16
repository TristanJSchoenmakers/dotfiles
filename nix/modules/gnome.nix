{ pkgs, ... }:

{
  services.desktopManager.gnome.enable = true;

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
    showtime
    simple-scan
    snapshot
    totem
    geary
  ]);

  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "Adwaita-dark";
        gtk-enable-primary-paste = false; # Disables copy-paste with middle-mouse button
        icon-theme = "Flat-Remix-Red-Dark";
        font-name = "Noto Sans Medium 11";
        # cursor-size = lib.gvariant.mkInt32 64;
        document-font-name = "Noto Sans Medium 11";
        monospace-font-name = "Noto Sans Mono Medium 11";
      };
    }
  ];
}

