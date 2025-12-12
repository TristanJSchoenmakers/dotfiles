{ pkgs, ... }:

let
  secrets = if builtins.pathExists ./secrets.nix
              then import ./secrets.nix
              else {};
in
{
  environment.systemPackages = with pkgs; [
    # terminal, CLI & TUI's
    kubectl
    doctl
    lens
    # Build tools
    (with dotnetCorePackages; combinePackages [
      sdk_8_0-bin
      sdk_9_0-bin
    ])
    dotnet-aspnetcore_8
    dotnet-aspnetcore_9
    azure-functions-core-tools
    nodejs_20
    yarn
    zulu17
    # IDE & LSP's
    jetbrains.rider
    android-studio
    # applications
    slack
  ];

  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-7.0.410"
    "dotnet-sdk-wrapped-7.0.410"
  ];

  environment.sessionVariables.ANDROID_HOME = "$HOME/Android/Sdk";
  environment.sessionVariables.DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_9_0-bin}/share/dotnet";
  programs.adb.enable = true;
  # abusers to access adb
  # kvm for hardware acceleration bug: https://nixos.wiki/wiki/Android#hardware_acceleration
  users.users.johndoe.extraGroups = ["adbusers" "kvm"];
  
  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };
  users.groups.cloudflared = { };

  systemd.services.my_tunnel = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "systemd-resolved.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token=${secrets.cloudflareTunnelToken}";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };
}
