{ config, lib, ... }:
let
  inherit (config.userSettings.theme) opacity borderRadius;
in
{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      backdrop.enabled = true;
      brightness.enable_ddcutil = true;
      location.auto_locate = true;
      notification.background_opacity = opacity;
      osd.background_opacity = opacity;

      bar.default = {
        capsule_radius = borderRadius;
        concave_edge_corners = false;
        margin_ends = 0;
        radius = 0;
        shadow = false;

        start = [
          "session"
          "workspaces"
          "space"
          "taskbar"
        ];

        center = [
          "clock"
          "space"
          "weather"
        ];

        end = [
          "privacy"
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
              "tray"
              "caffeine"
              "power_profile"
              "launcher"
            ];
          }
        ];
      };

      dock = {
        enabled = true;
        auto_hide = true;
        background_opacity = opacity;
        radius = borderRadius;
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
        clipboard_enabled = false;
        corner_radius_scale = borderRadius;
        launch_apps_as_systemd_services = true;
        polkit_agent = true;
      };

      theme.templates = {
        enable_builtin_templates = false;
        enable_community_templates = false;
      };

      widget = {
        clock.format = "{:%A, %b %d  %H:%M}";
        network.show_label = false;
        privacy.hide_inactive = true;
        space.type = "spacer";
        tray.drawer = true;
        weather.show_condition = false;

        taskbar = {
          capsule = true;
          inactive_opacity = 0.6;
          only_active_workspace = true;
        };

        workspaces = {
          hide_when_empty = true;
          occupied_color = "on_surface_variant";
          style = "minimal";
        };
      };
    };
  };

  # removes GUI-managed overrides so it reloads the nix conf
  home.activation.resetNoctaliaGuiOverrides = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    stateFile="''${XDG_STATE_HOME:-$HOME/.local/state}/noctalia/settings.toml"
    if [ -f "$stateFile" ]; then
      run : > "$stateFile"
    fi
  '';
}
