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
      pkgs.drill
      pkgs.wireshark
      pkgs.lsof
      pkgs.nano
      pkgs.unstable.neovim
      pkgs.autojump
      pkgs.slack
      pkgs.yakuake
      pkgs.authy
      pkgs.thunderbird
      pkgs.protonmail-bridge
      pkgs.tailscale
      pkgs.git
      pkgs.home-manager
      pkgs.obsidian
      pkgs.syncthing
      pkgs.syncthingtray
      pkgs.python311
      pkgs.chromium
      pkgs.nerdfonts
    ];
  };
  programs = {
    vscode = {
      enable = true;
      package = pkgs.unstable.vscode;
      userSettings = {
      "window.titleBarStyle" = "custom";
      "files.autoSave" = "afterDelay";
      "workbench.colorTheme" = "Gruvbox Dark Soft";
      };
    };
  };

  # fonts.packages = with pkgs; [
  #   noto-fonts
  #   nerdfonts
  # ];
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
