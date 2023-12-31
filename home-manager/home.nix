{
  inputs,
  lib,
  config,
  pkgs,
  outputs,
  ...
}: {
  imports = [
    ../modules/firefox/default.nix
    ../modules/syncthing.nix
    #./modules/vscode.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };
  home = {
    username = "marcus";
    homeDirectory = "/home/marcus";
    packages = [
      pkgs.nmap
      pkgs.tmux
      pkgs.drill
      pkgs.wireshark
      pkgs.lsof
      pkgs.nano
      pkgs.unstable.neovim
      pkgs.autojump
      pkgs.slack
      pkgs.yakuake
      pkgs.authy
      pkgs.dig
      pkgs.thunderbird
      pkgs.protonmail-bridge
      pkgs.tailscale
      pkgs.git
      pkgs.home-manager
      pkgs.mosh
      #pkgs.unstable.obsidian
      pkgs.syncthing
      pkgs.python311
      pkgs.python311Packages.pip
      pkgs.chromium
      pkgs.byobu
      pkgs.remmina
      pkgs.wl-clipboard
    ];
  };

  programs = {
    vscode = {
      enable = true;
      package = pkgs.unstable.vscode;
      userSettings = {
      "window.titleBarStyle" = "custom";
      "files.autoSave" = "afterDelay";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "git.autofetch" = true;
      "git.confirmSync" = false;
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      };
    };
      # environmentVariables.sessionVariables = {
      #   NIXOS_OZONE_WL = "1";
      # };
    # };
    # _1password.enable = {
    #   package = pkgs.unstable._1password;
    #   enable = true;
    # };
    # _1password-gui = {
    #   enable = true;
    #   polkitPolicyOwners = [ "marcus" ];
    #   package = pkgs.unstable._1password-gui;
    # };
  };
  
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
