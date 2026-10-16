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
      backdrop.enabled = true; # niri

      bar.default = {
        position = "bottom";
        background_opacity = opacity;
        margin_ends = 10;
        margin_edge = 5;
        concave_edge_corners = false;
        thickness = 30;
        radius = radius;
        capsule_radius = radius;

        start = [
          "notifications"
          "workspaces"
          "taskbar"
        ];

        center = [
          "power_profile"
          "clock"
          "caffeine"
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
        polkit_agent = true;
        panel.transparency_mode = "soft";
      };

      widget = {
        keyboard_layout.show_label = false;
        media.hide_artist = true;
        network.show_label = false;
        tray.drawer = true;
        privacy.hide_inactive = true;
        clock.format = "{:%A %H:%M}";
        volume.show_label = false;
        brightness.show_label = false;

        taskbar = {
          scale = 1.2;
          inactive_opacity = 0.6;
          only_active_workspace = true;
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
