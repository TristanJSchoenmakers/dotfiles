{ pkgs,  ... }:

let
  typst-preview-popup = pkgs.writeShellScriptBin "typst-preview-popup" ''
    url="http://127.0.0.1:23635"
    class="brave-127.0.0.1__-Default"
    if hyprctl clients -j | jq -e --arg c "$class" '.[] | select(.class==$c)' >/dev/null 2>&1; then
      hyprctl dispatch focuswindow "class:^($class)$" || true
    else
      exec brave --app="$url"
    fi
  '';

  tinymist-typst-preview = pkgs.writeShellScriptBin "tinymist-typst-preview" ''
    (
      # wait up to ~20s for the background preview server to come up, then open it once
      for _ in $(seq 1 100); do
        if (exec 3<>/dev/tcp/127.0.0.1/23635) 2>/dev/null; then
          exec 3>&- 3<&-
          ${typst-preview-popup}/bin/typst-preview-popup &
          break
        fi
        sleep 0.2
      done
    ) &
    exec ${pkgs.tinymist}/bin/tinymist "$@"
  '';
in
{
  fonts.packages = with pkgs; [
    fira-code
    nerd-fonts.fira-code
    noto-fonts
  ];

  # Hyprland
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Cursor / theme fix: https://wiki.hypr.land/Nix/Hyprland-on-NixOS/#fixing-problems-with-themes & https://wiki.hypr.land/Hypr-Ecosystem/hyprcursor/
  environment.sessionVariables = {
    XCURSOR_THEME   = "Adwaita";
    XCURSOR_SIZE    = 24;
    HYPRCURSOR_SIZE = 24;
  };

  environment.systemPackages = with pkgs; [
    # display
    hyprpaper
    hyprshot
      libnotify
      wl-clipboard
      satty
    wf-recorder
      slurp
    vicinae
    ashell
    typst-preview-popup
    tinymist-typst-preview
  ];
}
