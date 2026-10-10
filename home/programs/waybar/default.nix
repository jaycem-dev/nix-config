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
      clock.format = "{:%A %H:%M}";
      "hyprland/workspaces".show-special = true;

      modules-left = [
        "hyprland/workspaces"
        "custom/ws-dots"
      ];

      modules-center = [
        "power-profiles-daemon"
        "clock"
        "idle_inhibitor"
      ];

      modules-right = [
        "privacy"
        "tray"
        "network"
        "bluetooth"
        "pulseaudio"
        "battery"
      ];

      "custom/ws-dots" = {
        exec = "ws-dots";
        return-type = "json";
        restart-interval = 5;
      };

      power-profiles-daemon = {
        format = "{icon}";
        format-icons = {
          performance = "󰓅";
          balanced = "󰗑";
          power-saver = "󰌪";
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
        on-click = "kitty -1 --app-id impala impala";
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
        format-connected = "󰂱";
        on-click = "kitty -1 --app-id bluetui bluetui";
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
