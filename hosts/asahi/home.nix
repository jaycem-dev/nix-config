{ lib, ... }:
{
  imports = [ ../../home ];

  userSettings = {
    theme = {
      name = "vesper";
      opacity = 0.9;
      # borderRadius = 10;
    };
  };

  programs.noctalia.settings.idle.behavior."lock-and-suspend" = {
    action = "lock_and_suspend";
    timeout = 300;
  };

  # asahi needs --impure to build
  home.shellAliases.ns = lib.mkForce "nh os switch --impure";

  # asahi display issue workaround
  wayland.windowManager.hyprland.extraConfig = ''
    hl.on("hyprland.start", function()
      hl.exec_cmd(
        [[hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })'; sleep 1; hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })']]
      )
    end)
  '';
}
