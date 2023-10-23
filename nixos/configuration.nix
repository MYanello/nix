{ 
  outputs,
  config,
  pkgs,
  inputs,
  lib,
  ... }:

{
  imports = [ 
      ./hardware-configuration.nix
      ./boot.nix 
      #inputs.home-manager.nixosModules.home-manager
    ];
  # home-manager = {
  #   extraSpecialArgs = { inherit inputs outputs; };
  #   users = {
  #     marcus = import ../home-manager/home.nix;
  #   };
  # };
  networking = {
    hostName = "nixpad"; 
    networkmanager.enable = true;
  };

  time.timeZone = "America/Chicago";

### Bluetooth and sound
  services.blueman.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
  sound.enable = true;
  security.rtkit.enable = true;
  hardware = {
    pulseaudio.enable = false;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Enable = "Source,Sink,Media,Socket";
    };
  };

  programs = { 
    zsh.enable = true;
  };

  services = {
    flatpak.enable = true;
    xserver = {
      enable = true;
      displayManager.defaultSession = "plasmawayland";
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      libinput.enable = true;
      desktopManager.plasma5.enable = true;
    };
  };

  environment.sessionVariables = {
    # vscode on wayland
    NIXOS_OZONE_WL = "1";
  };

  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marcus = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [];
  };
  
  environment.systemPackages = with pkgs; [
    git
    home-manager
    nerdfonts
  ];

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment? 

  # This is all rdp stuff that didn't seem to work
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  # systemd = {
  #   user.services.polkit-gnome-authentication-agent-1 = {
  #     description = "polkit-gnome-authentication-agent-1";
  #     wantedBy = [ "graphical-session.target" ];
  #     wants = [ "graphical-session.target" ];
  #     after = [ "graphical-session.target" ];
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #       Restart = "on-failure";
  #       TimeoutStopSec = 10;
  #     };
  #   };
  # };
}  
