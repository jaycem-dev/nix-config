{
  imports = [ ../../home/default.nix ];

  userSettings = {
    theme = {
      name = "catppuccin-mocha";
      opacity = 0.95;
      borderRadius = 5;
    };
  };

  # TODO: check if this is still needed
  # Asahi display issue workaround
  wayland.windowManager.hyprland.extraConfig = ''
    hl.on("hyprland.start", function()
        hl.exec_cmd(
            [[hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })'; sleep 1; hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })']]
        )
    end)
  '';
}
