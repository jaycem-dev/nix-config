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
      dock.background_opacity = opacity;
      location.auto_locate = true;
      notification.background_opacity = opacity;
      osd.background_opacity = opacity;
      wallpaper.directory = "~/Pictures/Wallpapers";
      bluetooth.connection_notifications = false;

      bar.default = {
        position = "top";
        background_opacity = opacity;
        margin_ends = 0;
        margin_edge = 0;
        padding = 5;
        concave_edge_corners = false;
        thickness = 25;
        radius = 0;
        capsule_radius = radius;

        start = [
          "workspaces"
          "taskbar"
        ];
        center = [
          "notifications"
          "power_profile"
          "clock"
          "caffeine"
          "launcher"
        ];
        end = [
          "privacy"
          "tray"
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "battery"
        ];
      };

      idle = {
        behavior = {
          lock = {
            action = "lock";
            timeout = 180;
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
        polkit_agent = true;
        panel.transparency_mode = "soft";
      };

      widget = {
        keyboard_layout.show_label = false;
        media.hide_artist = true;
        network.show_label = false;
        tray.drawer = true;
        privacy.hide_inactive = true;
        workspaces.occupied_color = "surface_container_highest";
        clock.format = "%A %H:%M";

        taskbar = {
          inactive_opacity = 0.6;
          only_active_workspace = true;
          scale = 1.2;
          capsule = true;
        };
      };
    };
  };

  # Clear GUI-managed overrides
  home.activation.clearNoctaliaOverrides = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
    run rm -f "${config.xdg.stateHome}/noctalia/settings.toml"
  '';
}
