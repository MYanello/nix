{ pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        useOSProber = true;
        efiInstallAsRemovable = true;
        efiSupport = true;
        default = "saved";
        device = "nodev";
        gfxmodeEfi = "3440x1440";
        font = "${pkgs.hack-font}/share/fonts/hack/Hack-Regular.ttf";
        fontSize = 36;
      };
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot/efi";
      };
    };
    initrd.luks.devices = {
      crypted = {
        device = "/dev/disk/by-partuuid/4eff1417-5aa4-480a-a4d8-31e98e464406";
        allowDiscards = true;
        preLVM = true;
      };   
    };
  };
}
