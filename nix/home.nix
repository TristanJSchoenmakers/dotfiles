{ inputs, config, pkgs, ... }:

let
  secrets = if builtins.pathExists ./secrets.nix
              then import ./secrets.nix
              else {};
in
{
  environment.systemPackages = with pkgs; [
    tigervnc
  #   discord
  ];
}
