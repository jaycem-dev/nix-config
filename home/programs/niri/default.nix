{ pkgs, config, ... }: {
  home.packages = with pkgs; [ nirius ];

  wayland.windowManager.niri = {
    enable = true;
    extraConfig = ''
      include optional=true "${config.xdg.configHome}/niri/kdl/main.kdl"

      window-rule {
        geometry-corner-radius ${toString config.userSettings.theme.borderRadius}
        clip-to-geometry true
      }
    '';

    settings = with config.lib.stylix.colors.withHashtag; {
      overview.backdrop-color = base00;

      layout = {
        background-color = base00;
        shadow.color = "${base00}70";
        insert-hint.color = "${base0C}80";

        focus-ring = {
          active-color = base0D;
          inactive-color = base02;
          urgent-color = base08;
        };

        border = {
          active-color = base0D;
          inactive-color = base02;
          urgent-color = base08;
        };

        tab-indicator = {
          active-color = base0D;
          inactive-color = base02;
          urgent-color = base08;
        };
      };

      recent-windows.highlight = {
        active-color = base0D;
        urgent-color = base08;
      };
    };
  };

  xdg.configFile."niri/kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Projects/nix-config/home/programs/niri/kdl";
}
