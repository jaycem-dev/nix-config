{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.noctalia.homeModules.default];

  home.activation.noctaliaStylixWallpaper = let
    awk = lib.getExe pkgs.gawk;
    mktemp = lib.getExe' pkgs.coreutils "mktemp";
    mv = lib.getExe' pkgs.coreutils "mv";
  in
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      stateFile="$HOME/.local/state/noctalia/settings.toml"
      if [[ -f "$stateFile" ]]; then
        tmp=$(${mktemp})
        ${awk} '/^\[wallpaper\./ {skip = 1; next} /^\[/ {skip = 0} !skip' "$stateFile" > "$tmp"
        ${mv} "$tmp" "$stateFile"
      fi
    '';

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
    settings = {
      brightness.enable_ddcutil = true;
      desktop_widgets.enabled = false;
      notification.background_opacity = config.userSettings.theme.opacity;
      osd.background_opacity = config.userSettings.theme.opacity;

      shell = {
        launch_apps_as_systemd_services = true;
        corner_radius_scale = config.userSettings.borderRadius;
        polkit_agent = true;
        settings_show_advanced = false;
        panel.transparency_mode = "soft";
        launcher = {
          categories = false;
          compact = true;
        };
      };

      theme.templates = {
        enable_builtin_templates = false;
        enable_community_templates = false;
      };

      bar.default = {
        background_opacity = config.userSettings.theme.opacity;
        start = ["session" "workspaces" "taskbar"];
        center = ["caffeine" "clock" "launcher"];
        end = ["media" "privacy" "tray" "network" "bluetooth" "volume" "brightness" "battery" "notifications"];
        capsule_radius = config.userSettings.borderRadius;
        radius = 0;
        margin_ends = 0;
        shadow = false;
        widget_spacing = 10;
      };

      widget = {
        clock.format = "{:%A, %b  %H:%M}";
        network.show_label = false;
        tray.capsule = true;
        privacy.hide_inactive = true;
        battery.display_mode = "graphic";
        media = {
          album_art_only = true;
          hide_when_no_media = true;
        };
        taskbar = {
          capsule = true;
          inactive_opacity = 0.6;
          only_active_workspace = true;
        };
      };
    };
  };
}
