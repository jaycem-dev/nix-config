{
  config,
  inputs,
  lib,
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
      blur = true;
      "hyprland/workspaces#main".show-special = true;
      clock.format = "{:%A %H:%M}";
      privacy.icon-spacing = 10;
      tray.spacing = 10;

      modules-left = [
        "clock"
        "hyprland/workspaces#taskbar"
      ];

      modules-center = [
        "power-profiles-daemon"
        "hyprland/workspaces#main"
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

      "hyprland/workspaces#taskbar" = {
        format = "{windows}";
        format-window-separator = "";
        active-only = true;
        workspace-taskbar = {
          enable = true;
          update-active-window = true;
        };
      };

      power-profiles-daemon = {
        format = "{icon}";
        format-icons = {
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
        format-connected = "󰂰";
        on-click = "kitty -1 --app-id bluetui bluetui";
      };
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
