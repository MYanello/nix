{ inputs, pkgs, ... }:
{
    programs.vscode = {
        enable = true;
        package = pkgs.unstable.vscode;
        userSettings = {
        "window.titleBarStyle" = "custom";
        "files.autoSave" = "afterDelay";
        "workbench.colorTheme" = "Catppuccin Mocha";
        "git.autofetch" = true;
        "git.confirmSync" = true;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        };
    };
}