{ config, ... }:
let
  radius = config.userSettings.theme.borderRadius;
  opacity = config.userSettings.theme.opacity;
in
{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;
    settings = {
      brightness.enable_ddcutil = true;
      desktop_widgets.enabled = false;
      location.auto_locate = true;
      notification.background_opacity = opacity;
      osd.background_opacity = opacity;

      bar.default = {
        thickness = 30;
        shadow = false;
        background_opacity = opacity;
        concave_edge_corners = false;
        margin_ends = 0;
        radius = 0;

        start = [
          "session"
          "workspaces"
          "space"
          "taskbar"
        ];
        center = [
          "clock"
          "weather"
        ];
        end = [
          "group:g1"
          "space"
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "battery"
          "notifications"
        ];

        capsule_group = [
          {
            enabled = true;
            id = "g1";
            members = [
              "privacy"
              "tray"
              "launcher"
              "screenshot"
              "caffeine"
              "power_profile"
            ];
          }
        ];
      };

      dock = {
        auto_hide = true;
        background_opacity = opacity;
        enabled = true;
        radius = radius;
        reserve_space = false;
      };

      idle.behavior = {
        lock = {
          action = "lock";
          timeout = 180;
        };
        lock-and-suspend = {
          action = "lock_and_suspend";
          timeout = 300;
        };
        screen-off = {
          action = "screen_off";
          timeout = 120;
        };
      };

      shell = {
        launch_apps_as_systemd_services = true;
        polkit_agent = true;
        settings_show_advanced = false;
        corner_radius_scale = radius;

        session.actions = [
          { action = "lock"; }
          {
            action = "logout";
            command = "hyprshutdown";
          }
          { action = "lock_and_suspend"; }
          {
            action = "reboot";
            command = "hyprshutdown -p 'systemctl reboot'";
          }
          {
            action = "shutdown";
            command = "hyprshutdown -p 'systemctl poweroff'";
            variant = "destructive";
          }
        ];
      };

      theme.templates = {
        enable_builtin_templates = false;
        enable_community_templates = false;
      };

      widget = {
        network.show_label = false;
        privacy.hide_inactive = true;
        space.type = "spacer";
        taskbar = {
          capsule = true;
          inactive_opacity = 0.6;
          only_active_workspace = true;
        };
      };
    };
  };
}
