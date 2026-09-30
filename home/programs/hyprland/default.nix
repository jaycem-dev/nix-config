{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    hyprshutdown
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    settings.config.decoration.rounding = config.userSettings.theme.borderRadius;
    extraConfig = ''
      require("lua.main")

      hl.window_rule({
        match = { fullscreen = true },
        border_color = "rgb(${config.lib.stylix.colors.red})",
      })
    '';
  };

  xdg.configFile."hypr/lua".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Projects/nix-config/home/programs/hyprland/lua";
}
