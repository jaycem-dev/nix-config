{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
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
      privacy.icon-spacing = 10;
      tray.spacing = 10;

      modules-left = [
        "hyprland/workspaces"
      ];

      modules-center = [
        "hyprland/window"
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
        "clock"
      ];

      "hyprland/workspaces" = {
        show-special = true;
      };

      power-profiles-daemon = {
        format = "{icon}";
        format-icons = {
          default = "󰾅";
          performance = "󰓅";
          balanced = "󰾅";
          power-saver = "󰾆";
        };
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        on-click = "pavucontrol";
        format-muted = "󰝟";
        format-icons = {
          headphone = "󰋋";
          default = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
        };
      };

      battery = {
        format = "{icon} {capacity}%";
        format-critical = "LOW BATTERY {icon} {capacity}%";
        states.critical = 20;
        format-icons = {
          charging = "󱐋";
          default = [
            "󰁻"
            "󰁽"
            "󰁿"
            "󰂁"
            "󰁹"
          ];
        };
      };

      network = {
        format-wifi = "󰖩";
        format-ethernet = "󰈀";
        format-linked = "󱎔";
        format-disconnected = "󰀦";
        on-click = "spawn-or-focus tui impala";
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "󰅶";
          deactivated = "󰛊";
        };
      };

      bluetooth = {
        format = "󰂯";
        format-off = "󰂲";
        format-connected = "󰂰";
        on-click = "spawn-or-focus tui bluetui";
      };
    };

    style = lib.mkAfter (
      ''
        * {
            font-family: "${config.stylix.fonts.monospace.name}", "Symbols Nerd Font Mono";
            border-radius: ${toString config.userSettings.theme.borderRadius};
        }

        window#waybar {
            background-color: ${config.stylix.targets.waybar.background};
        }
      ''
      + builtins.readFile ./style.css
    );
  };
}
