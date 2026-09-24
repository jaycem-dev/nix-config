{
  config,
  pkgs,
  flakePath,
  ...
}:
let
  luaDir = "${flakePath}/home/programs/hyprland/lua";
in
{
  home.packages = with pkgs; [
    hyprshutdown
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    settings.config.decoration.rounding = config.userSettings.theme.borderRadius;
    extraConfig = ''
      require("${luaDir}/main")
    '';
  };

  # Populate ~/.config/hypr/lua from the vendored lua/ dir.
  xdg.configFile."hypr/lua".source = config.lib.file.mkOutOfStoreSymlink luaDir;
}
