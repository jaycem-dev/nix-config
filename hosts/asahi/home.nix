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

  # Sleep/suspend does not work reliably on Asahi, so don't suspend
  # Lid close is handled as a regular poweroff in hosts/asahi/default.nix instead until there's a fix
  # programs.noctalia.settings.idle.behavior."lock-and-suspend" = {
  #   action = "lock_and_suspend";
  #   timeout = 300;
  # };

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
