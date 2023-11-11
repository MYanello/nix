{ inputs, pkgs, ... }:
{
  services.syncthing = {
    enable = true;    
    # user = "nixpad";
    # devices = { 
    #   "marcus-server" = { id = "MAOKXUC-AAJQXNS-QOQU5ZC-MEDL5XK-AMOOTRS-UGJDTDI-MNDKHWT-HRUWSAZ"; };
    # };
    # folders = {
    #   "Synced Folder" = {
    #     path = "/home/marcus/Documents";
    #     devices = [ "marcus-server" ];
    #   };
    # };
  };
}