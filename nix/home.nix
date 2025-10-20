{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tigervnc
    foliate
  ];
}
