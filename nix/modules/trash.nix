{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.trashy
  ];

  systemd.services.trashy-empty = {
    description = "Empty Trash older than 2 weeks";

    serviceConfig = {
      Type = "oneshot";
      User = "johndoe";

      # Minimal, explicit user environment
      Environment = [
        "HOME=/home/johndoe"
        "XDG_DATA_HOME=/home/johndoe/.local/share"
      ];

      ExecStart = "${pkgs.trashy}/bin/trash empty --older-than 2weeks --force";
    };
  };

  systemd.timers.trashy-empty = {
    description = "Run trash cleanup daily";
    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "1h";
      Unit = "trashy-empty.service";
    };
  };
}

