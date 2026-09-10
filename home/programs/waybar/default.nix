{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./modules.nix
  ];

  # TODO: override stylix instead of defining everything
  stylix.targets.waybar.addCss = false;

  programs.waybar = {
    enable = true;
    package = inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default;
    systemd.enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      spacing = 15;
      height = 30;

      # define this on a niri module
      modules-left = [
        "niri/workspaces#main"
        "niri/workspaces#taskbar"
      ];

      modules-center = [
        "clock"
      ];

      modules-right = [
        "privacy"
        "tray"
        "idle_inhibitor"
        "power-profiles-daemon"
        "network"
        "bluetooth"
        "pulseaudio"
        "battery"
      ];
    };

    style = lib.mkAfter ''
      * {
        font-family: "${config.stylix.fonts.monospace.name}", "Symbols Nerd Font Mono";
        border-radius: ${toString config.userSettings.theme.borderRadius};
      }

      window#waybar {
        background-color: ${config.stylix.targets.waybar.background};
      }

      ${builtins.readFile ./style.css}
    '';
  };
}
