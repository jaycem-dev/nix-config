{ config, lib, ... }:
let
  radius = config.userSettings.theme.borderRadius;
  # TODO: look for a better way to scale this
  radiusScale = if radius == 0 then 0 else 1;
  opacity = config.userSettings.theme.opacity;
in
{
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
      wallpaper.directory = "~/Pictures/Wallpapers";

      bar.default = {
        background_opacity = opacity;
        concave_edge_corners = false;
        margin_ends = 0;
        thickness = 30;
        radius = 0;
        shadow = false;

        start = [
          "launcher"
          "workspaces"
          "taskbar"
        ];
        center = [
          "clock"
          "weather"
        ];
        end = [
          "privacy"
          "group:g1"
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "battery"
          "notifications"
        ];
        capsule_group = [
          {
            id = "g1";
            members = [
              "tray"
              "caffeine"
              "keyboard_layout"
              "screenshot"
              "power_profile"
            ];
          }
        ];
      };

      idle = {
        behavior = {
          lock = {
            action = "lock";
            timeout = 180;
          };
          "lock-and-suspend" = {
            action = "lock_and_suspend";
            timeout = 300;
          };
          "screen-off" = {
            action = "screen_off";
            timeout = 120;
          };
        };
      };

      shell = {
        corner_radius_scale = radiusScale;
        launch_apps_as_systemd_services = true;
        panel.transparency_mode = "soft";

      };

      theme.templates = {
        enable_builtin_templates = false;
        enable_community_templates = false;
      };

      widget = {
        clock.format = "{:%A, %b %d  %H:%M}";
        keyboard_layout.show_label = false;
        media.hide_artist = true;
        network.show_label = false;
        privacy.hide_inactive = true;
        tray.drawer = true;
        weather.show_condition = false;
        taskbar = {
          capsule = true;
          inactive_opacity = 0.6;
          only_active_workspace = true;
        };
      };
    };
  };

  # Clear GUI-managed overrides
  home.activation.clearNoctaliaOverrides = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
    run rm -f "${config.xdg.stateHome}/noctalia/settings.toml"
  '';
}
