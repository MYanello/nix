{ inputs, pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    # configDir = "/home/marcus/Documents/.config/syncthing";
    # user = "nixpad";
    # devices = { 
    #   "marcus-server" = { id = "MAOKXUC-AAJQXNS-QOQU5ZC-MEDL5XK-AMOOTRS-UGJDTDI-MNDKHWT-HRUWSAZ"; };
    # };
    #sharedFolders = {
    #   "Synced Folder" = {
    #     path = "/home/marcus/Documents";
    #     devices = [ "marcus-server" ];
    #   };
   # };
  };
}