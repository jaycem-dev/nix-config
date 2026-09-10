{
  programs.waybar.settings.mainBar = {
    clock.format = "{:%A, %b %d  %H:%M}";
    privacy.icon-spacing = 10;
    tray.spacing = 10;
    "niri/workspaces#main".format = "{index}";

    "niri/workspaces#taskbar" = {
      current-only = true;
      workspace-taskbar.enable = true;
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
      format-charging = "󱐋 {capacity}%";
      format-critical = "LOW BATTERY {icon} {capacity}%";
      states.critical = 20;
      format-icons = {
        charging = "󰂄";
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
      on-click = "launch-or-focus --tui impala";
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
      on-click = "launch-or-focus --tui bluetui";
    };
  };
}
