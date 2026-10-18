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
      # margin = "0 5px 5px 5px";
      spacing = 15;
      height = 30;
      blur = true;
      privacy.icon-spacing = 10;
      tray.spacing = 10;

      modules-left = [
        "hyprland/workspaces#main"
        "hyprland/workspaces#taskbar"
        "niri/workspaces#main"
        "niri/workspaces#taskbar"
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

      "hyprland/workspaces#main" = {
        format = "{icon}";
        show-special = true;
        format-icons = {
          "special:scratch" = "S";
          "special:music" = "M";
          "special:ai" = "A";
        };
      };

      "hyprland/workspaces#taskbar" = {
        format = "{windows}";
        format-window-separator = "";
        active-only = true;
        workspace-taskbar = {
          enable = true;
          update-active-window = true;
        };
      };

      "niri/workspaces#main" = {
        format = "{index}";
      };

      "niri/workspaces#taskbar" = {
        current-only = true;
        workspace-taskbar.enable = true;
      };

      clock = {
        format = "{:%A %H:%M}";
        tooltip-format = "<tt>{calendar}</tt>";
        calendar = with config.lib.stylix.colors.withHashtag; {
          mode = "month";
          on-scroll = 1;
          first-day-of-week = 1; # monday
          format = {
            months = "<span color='${base0D}'><b>{}</b></span>";
            weekdays = "<span color='${base0C}'><b>{}</b></span>";
            today = "<span color='${base0A}'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
        on-click = "brave-origin --app=https://calendar.proton.me";
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
          headset = "󰋎";
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
