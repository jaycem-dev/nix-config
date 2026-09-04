{
  config,
  lib,
  ...
}: let
  opacity = config.userSettings.theme.opacity;
  borderRadius = config.userSettings.theme.borderRadius;
in {
  # Clear GUI-managed overrides so the config stays declarative
  # https://docs.noctalia.dev/noctalia/configuration/#file-locations
  home.activation.clearNoctaliaOverrides = lib.hm.dag.entryAfter ["writeBoundary"] ''
    : > "${config.xdg.stateHome}/noctalia/settings.toml" 2>/dev/null || true
  '';
  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      brightness.enable_ddcutil = true;
      desktop_widgets.enabled = false;
      dock.background_opacity = opacity;
      location.auto_locate = true;
      notification.background_opacity = opacity;
      osd.background_opacity = opacity;

      bar.default = {
        thickness = 30;
        background_opacity = opacity;
        concave_edge_corners = false;
        margin_ends = 0;
        radius = borderRadius;
        shadow = false;

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
          "group:actions"
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
            id = "actions";
            opacity = opacity;
            radius = borderRadius;
            members = [
              "privacy"
              "tray"
              "caffeine"
              "power_profile"
              "nightlight"
            ];
          }
        ];
      };

      idle = {
        behavior = {
          lock = {
            action = "lock";
            timeout = 240;
          };
          "lock-and-suspend" = {
            action = "lock_and_suspend";
            timeout = 300;
          };
          "screen-off" = {
            action = "screen_off";
            timeout = 180;
          };
        };
      };

      shell = {
        corner_radius_scale = borderRadius;
        launch_apps_as_systemd_services = true;
        polkit_agent = true;
        clipboard_enabled = false;
      };

      widget = {
        network.show_label = false;
        clock.format = "{:%A, %b %d  %H:%M}";
        privacy.hide_inactive = true;
        weather.show_condition = false;

        space = {
          length = 10;
          type = "spacer";
        };

        taskbar = {
          capsule_radius = borderRadius;
          inactive_opacity = 0.5;
          only_active_workspace = true;
        };

        workspaces = {
          hide_when_empty = true;
          style = "minimal";
          occupied_color = "on_surface";
        };
      };
    };
  };
}
