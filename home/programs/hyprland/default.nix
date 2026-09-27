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
    extraConfig = ''
      require("lua.main")
    '';
  };

  xdg.configFile."hypr/lua".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Projects/nix-config/home/programs/hyprland/lua";
}
