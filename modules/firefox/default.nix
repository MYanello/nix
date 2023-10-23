{ inputs, config, pkgs, lib, buildFirefoxXpiAddon, ... }:

let
  myconfig = ''
    user_pref("browser.firefox-view.feature-tour",{"message":"FIREFOX_VIEW_FEATURE_TOUR","screen":"","complete":true});
    user_pref("browser.urlbar.sponsoredTopSites",false);
    user_pref("extensions.formautofill.creditCards.enabled",false);
    user_pref("extensions.pocket.enabled",false);
    user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites",false);
    user_pref("browser.shell.checkDefaultBrowser",false);
    user_pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned","");
    user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket",false);
  '';
  firefox-package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
    extraNativeMessagingHosts = [ (pkgs.callPackage ./firefox-profile-switcher-connector.nix { }) ];
    extraPolicies = { ExtensionSettings = { }; };
  };
  #}) [ "override" "overrideDerivation" ];
in {
  imports = [ 
  ];

  programs.firefox = {
    enable = true;
    package = firefox-package;
    profiles = {
      Personal = {
        isDefault = true;
        search = {
          default = "DuckDuckGo";
          force = true;
        };
        extraConfig = myconfig;
      };
      Work = {
        id = 1;
        isDefault = false;
        extraConfig = myconfig;
      };
      Support-User = {
        id = 2;
        isDefault = false;
        extraConfig = myconfig;
      };
      #extensions = builtins.attrValues addons;
    };
  };

  xdg.configFile = {
    "firefoxprofileswitcher/config.json".text = ''
      {"browser_binary": "${firefox-package}/bin/firefox"}
    '';
  };

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
  };
}
