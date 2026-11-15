{ pkgs, ... }:
{
  # xdg-desktop-portal-hyprland does not implement RemoteDesktop portal yet
  # Tracking upstream:
  #   https://github.com/hyprwm/xdg-desktop-portal-hyprland/issues/252
  #   https://github.com/hyprwm/xdg-desktop-portal-hyprland/pull/308
  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-luminous ];
    config.hyprland."org.freedesktop.impl.portal.RemoteDesktop" = [ "luminous" ];
  };
}
