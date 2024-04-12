{ config, pkgs, ... }:
# let
#  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
#in
{
  programs.home-manager.enable = true;
  # imports = [
    # (import "${home-manager}/nixos")
  # ];

  users.my_username = {
    home.stateVersion = "18.09";
  };

  # home-manager.programs.git = {
  #   enable = true;
  #   userName = "TristanJSchoenmakers";
  #   userEmail = "tristansjh@gmail.com";
  # };
}
